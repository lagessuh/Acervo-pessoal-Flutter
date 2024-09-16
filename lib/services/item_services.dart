import 'package:acervo/models/categoria.dart';
import 'package:acervo/models/item.dart';
import 'package:acervo/models/userlocal.dart';
import 'package:acervo/utils/exceptions/my_firebase_auth_exceptions.dart';
import 'package:acervo/utils/exceptions/my_firebase_exceptions.dart';
import 'package:acervo/utils/exceptions/my_platform_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class ItemServices {
  //obter uma referência (instância) do firebase (cloudfirestore)
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //Obter referência da coleção no firebase
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('itens');
  Item _itens = Item();

  //método para persistir dados no firebase
  // Future<bool> addItem({Item? item}) async {
  //   try {
  //     final doc = await _firestore.collection('itens').add(item!.toMap());
  //     _itens = item;
  //     _itens.id = doc.id;
  //     return Future.value(true);
  //   } on FirebaseException catch (e) {
  //     debugPrint(e.code.toString());
  //     return Future.value(false);
  //   }
  // }

  // Future<bool> addItem({Item? item}) async {
  //   try {
  //     // Cria um documento com um ID gerado automaticamente
  //     final docRef = _firestore.collection('itens').doc();

  //     // Atribui o ID gerado ao objeto 'item'
  //     item!.id = docRef.id;

  //     // Grava o item no Firestore usando o ID gerado
  //     await docRef.set(item.toMap());

  //     // Atualiza o item na instância local, se necessário
  //     _itens = item;

  //     return Future.value(true);
  //   } on FirebaseException catch (e) {
  //     debugPrint(e.code.toString());
  //     return Future.value(false);
  //   }
  // }

  Future<bool> addItem({Item? item}) async {
    try {
      // Obter o usuário logado
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        // Caso o usuário não esteja logado, retorna false
        print('Usuário não logado');
        return Future.value(false);
      }

      // Preencher o userlocal com os dados do usuário logado
      item!.userlocal = UserLocal(
        id: currentUser.uid, // ou outro dado relevante
      );

      // Cria um documento com um ID gerado automaticamente
      final docRef = _firestore.collection('itens').doc();

      // Atribui o ID gerado ao objeto 'item'
      item.id = docRef.id;

      // Grava o item no Firestore usando o ID gerado
      await docRef.set(item.toMap());

      // Atualiza o item na instância local, se necessário
      _itens = item;

      return Future.value(true);
    } on FirebaseException catch (e) {
      debugPrint(e.code.toString());
      return Future.value(false);
    }
  }

  Stream<QuerySnapshot> getItensByUser(UserLocal userLocal) {
    try {
      return _collectionRef
          .where('userLocal.id', isEqualTo: userLocal.id)
          .snapshots();
    } on FirebaseAuthException catch (e) {
      throw MyFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw MyFirebaseExceptions(e.code).message;
    } on PlatformException catch (e) {
      throw MyPlatformExceptions(e.code).message;
    } catch (e) {
      if (kDebugMode)
        debugPrint('Algo está errado. Por favor, tente novamente');
      rethrow;
    }
  }

  Stream<QuerySnapshot> getItem() {
    try {
      return _collectionRef.orderBy('data').snapshots();
    } on FirebaseAuthException catch (e) {
      throw MyFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw MyFirebaseExceptions(e.code).message;
    } on PlatformException catch (e) {
      throw MyPlatformExceptions(e.code).message;
    } catch (e) {
      if (kDebugMode)
        debugPrint('Algo está errado. Por favor, tente novamente');
      rethrow;
    }
  }

  Stream<QuerySnapshot> getItemByDate() {
    final Timestamp now = Timestamp.fromDate(DateTime.now());
    final Timestamp yesterday = Timestamp.fromDate(
      DateTime.now().subtract(const Duration(days: 1)),
    );

//ajustar data
    return _collectionRef
        .where('createdAt', isLessThan: now, isGreaterThan: yesterday)
        .orderBy('itens')
        .snapshots();
  }

  Future updateItem(Item item) async {
    return _firestore.collection('itens').doc(item.id).set(item.toMap());
  }

  Future deleteItem(String id) async {
    return _firestore.collection('itens').doc(id).delete();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllItem(
      String searchKey) async {
    var data = await _firestore
        .collection('categorias')
        .where('categoria', isGreaterThanOrEqualTo: searchKey)
        .where('categoria', isLessThan: '${searchKey}z')
        .orderBy('categoria')
        .get();
    return data;
  }

  Stream<QuerySnapshot> getItem2(String? searchKey) {
    return _collectionRef
        .orderBy('categorias')
        .where('categoria', isGreaterThanOrEqualTo: searchKey)
        .where('categoria', isLessThan: '${searchKey!}z')
        .orderBy('categoria')
        .snapshots();
  }

  //método para obter dados no firebase
  Future<List> searchItemByCategoria(String categoria) async {
    List listCategoria = [];
    final result = await _collectionRef
        .where(
          'categoria',
          isGreaterThanOrEqualTo: categoria,
          isLessThan: '${categoria}z',
        )
        .get();
    listCategoria = result.docs.map((e) => e.data()).toList();
    return listCategoria;
  }

  //lista da homepage
  Stream<List<Item>> getItens({List<String>? categorias, String? searchText}) {
    Query query =
        _firestore.collection('itens').orderBy('data', descending: true);

    if (categorias != null && categorias.isNotEmpty) {
      query = query.where('categoria.id', whereIn: categorias);
    }

    if (searchText != null && searchText.isNotEmpty) {
      query = query
          .where('nome', isGreaterThanOrEqualTo: searchText)
          .where('nome', isLessThanOrEqualTo: searchText + '\uf8ff');
    }

    return query.snapshots().map((snapshot) => snapshot.docs.map((doc) {
          final data = doc.data();
          if (data != null) {
            return Item.fromMap(data as Map<String, dynamic>);
          } else {
            throw Exception("Item data is null");
          }
        }).toList());
  }

  // Método para buscar os itens mais recentes
  Future<List<Item>> getItensRecentes() async {
    try {
      final collectionRef = _firestore.collection('itens');
      final snapshot =
          // await collectionRef.orderBy('data', descending: true).limit(10).get();
          await collectionRef.limit(10).get();

      if (snapshot.docs.isEmpty) {
        print("Nenhum item encontrado. A coleção pode ainda não existir.");
        return [];
      }

      return snapshot.docs
          .map((doc) => Item.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Erro ao buscar itens recentes: $e");
      throw Exception('Erro ao buscar itens recentes: $e');
    }
  }

  // Future<List<Item>> getItensRecentes() async {
  //   try {
  //     QuerySnapshot snapshot = await _firestore
  //         .collection('itens')
  //         .orderBy('data', descending: true)
  //         .limit(10)
  //         .get();

  //     // Verifica se há documentos retornados
  //     if (snapshot.docs.isEmpty) {
  //       // Você pode tratar o caso onde não há itens, se necessário
  //       return [];
  //     }

  //     return snapshot.docs
  //         .map((doc) => Item.fromMap(doc.data() as Map<String, dynamic>))
  //         .toList();
  //   } catch (e) {
  //     throw Exception('Erro ao buscar itens recentes: $e');
  //   }
  // }

  // Método para buscar itens filtrados por categoria e texto
  // Future<List<Item>> getItensFiltrados(
  //     List<Categoria> categorias, String searchText) async {
  //   try {
  //     Query query = _firestore.collection('itens');

  //     if (categorias.isNotEmpty) {
  //       List<String> categoriaIds = categorias.map((e) => e.id!).toList();
  //       query = query.where('categoria.id', whereIn: categoriaIds);
  //     }

  //     if (searchText.isNotEmpty) {
  //       query = query
  //           .where('nome', isGreaterThanOrEqualTo: searchText)
  //           .where('nome', isLessThanOrEqualTo: searchText + '\uf8ff');
  //     }

  //     QuerySnapshot snapshot = await query.get();

  //     return snapshot.docs
  //         .map((doc) => Item.fromMap(doc.data() as Map<String, dynamic>))
  //         .toList();
  //   } catch (e) {
  //     throw Exception('Erro ao filtrar itens: $e');
  //   }
  // }
// Método para buscar itens filtrados por categoria e texto
  Future<List<Item>> getItensFiltrados(
      List<Categoria> categorias, String searchText) async {
    try {
      Query query = _firestore.collection('itens');

      if (categorias.isNotEmpty) {
        List<String> categoriaNomes = categorias.map((e) => e.nome!).toList();
        query = query.where('categoria.nome', whereIn: categoriaNomes);
      }

      if (searchText.isNotEmpty) {
        query = query
            .where('nome', isGreaterThanOrEqualTo: searchText)
            .where('nome', isLessThanOrEqualTo: searchText + '\uf8ff');
      }

      QuerySnapshot snapshot = await query.get();

      return snapshot.docs
          .map((doc) => Item.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Erro ao filtrar itens: $e');
    }
  }

  // Future<List<Item>> getItensFiltrados(
  //     List<Categoria> categorias, String searchText) async {
  //   try {
  //     Query query = _firestore.collection('itens');

  //     // Verifique se categorias não está vazio e se IDs não são nulos
  //     if (categorias.isNotEmpty) {
  //       List<String> categoriaIds = categorias
  //           .where((e) => e.id != null) // Filtra categorias com IDs não nulos
  //           .map((e) => e.id!)
  //           .toList();
  //       if (categoriaIds.isNotEmpty) {
  //         query = query.where('categoria.id', whereIn: categoriaIds);
  //       }
  //     }

  //     // Verifique se o texto de busca não está vazio
  //     if (searchText.isNotEmpty) {
  //       query = query
  //           .where('nome', isGreaterThanOrEqualTo: searchText)
  //           .where('nome', isLessThanOrEqualTo: searchText + '\uf8ff');
  //     }

  //     QuerySnapshot snapshot = await query.get();

  //     // Transforme os documentos em uma lista de itens
  //     return snapshot.docs
  //         .map((doc) => Item.fromMap(doc.data() as Map<String, dynamic>))
  //         .toList();
  //   } catch (e) {
  //     // Adicione logs para depuração
  //     print('Erro ao filtrar itens: $e');
  //     throw Exception('Erro ao filtrar itens: $e');
  //   }
  // }

  // Stream<List<Item>> getItens({List<String>? categorias, String? searchText}) {
  //   Query query =
  //       _firestore.collection('itens').orderBy('data', descending: true);

  //   if (categorias != null && categorias.isNotEmpty) {
  //     query = query.where('categoria.id', whereIn: categorias);
  //   }

  //   if (searchText != null && searchText.isNotEmpty) {
  //     query = query
  //         .where('nome', isGreaterThanOrEqualTo: searchText)
  //         .where('nome', isLessThanOrEqualTo: searchText + '\uf8ff');
  //   }

  //   return query.snapshots().map((snapshot) =>
  //       snapshot.docs.map((doc) => Item.fromMap(doc.data())).toList());
  // }

  //busca categorias
  Future<List<Categoria>> getAllCategorias() async {
    final querySnapshot = await _firestore.collection('categorias').get();
    return querySnapshot.docs
        .map((doc) => Categoria.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
