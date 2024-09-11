import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:acervo/models/categoria.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class CategoriaServices {
  //obter uma referência (instância) do firebase (cloudfirestore)
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //Obter referência da coleção no firebase
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('categorias');
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Categoria _categorias = Categoria();
  //método para persistir dados no firebase
  Future<bool> addCategoria({Categoria? categoria}) async {
    try {
      final doc = await _firestore
          .collection('categorias')
          .add(categoria!.toMapCategoria());
      _categorias = categoria;
      _categorias.id = doc.id;
      return Future.value(true);
    } on FirebaseException catch (e) {
      debugPrint(e.code.toString());
      return Future.value(false);
    }
  }

  Stream<QuerySnapshot> getCategorias() {
    return _collectionRef.orderBy('nome').snapshots();
  }

  Future updateCategoria(Categoria categorias) async {
    return _firestore
        .collection('categorias')
        .doc(categorias.id)
        .set(categorias.toMapCategoria());
  }

  Future deleteCategoria(String id) async {
    return _firestore.collection('categorias').doc(id).delete();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllCategorias(
      String searchKey) async {
    var data = await _firestore
        .collection('categorias')
        .where('nome', isGreaterThanOrEqualTo: searchKey)
        .where('nome', isLessThan: '${searchKey}z')
        .orderBy('nome')
        .get();
    return data;
  }

  Stream<QuerySnapshot> getCategoria2(String? searchKey) {
    return _collectionRef
        .orderBy('nome')
        .where('nome', isGreaterThanOrEqualTo: searchKey)
        .where('nome', isLessThan: '${searchKey!}z')
        .orderBy('nome')
        .snapshots();
  }

  //método para obter dados da Aquisicao no firebase
  Future<List> searchCategoriaByName(String nome) async {
    List<DocumentSnapshot> docs = [];
    List listCategorias = [];
    final result = await _collectionRef
        .where(
          'nome',
          isGreaterThanOrEqualTo: nome,
          isLessThan: '${nome}z',
        )
        .get();
    listCategorias = result.docs.map((e) => e.data()).toList();
    return listCategorias;
  }

  Future<List<Categoria>> getAllCategoriasItem(String filter) async {
    QuerySnapshot querySnapshot = await _collectionRef.orderBy('nome').get();
    return querySnapshot.docs.map((doc) {
      return Categoria(
        id: doc.id,
        nome: doc['nome'],
      );
    }).toList();
  }

  Future<List<Categoria>> getAllCategoriaDesejo(String filter) async {
    QuerySnapshot querySnapshot = await _collectionRef.orderBy('nome').get();
    return querySnapshot.docs.map((doc) {
      return Categoria(
        id: doc.id,
        nome: doc['nome'],
      );
    }).toList();
  }

  Future<List<Map<String, dynamic>>> getCategoriaToUser() async {
    List<Map<String, dynamic>> categorias = <Map<String, dynamic>>[];
    var doc;
    // var regions;
    try {
      await _firestore.collection("zones").get().then(
        (querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
            // print('${docSnapshot.id} => ${docSnapshot.data()}');
            categorias.add(docSnapshot.data());
          }
        },
        onError: (e) => print("Error completing: $e"),
      );

      debugPrint('zones - - > $categorias');
      // return Future.value(regions);
      return categorias;
    } on FirebaseException catch (e) {
      if (e.code != 'OK') {
        debugPrint('Problemas ao gravar dados do usuário com a imagem');
      } else if (e.code == 'ABORTED') {
        debugPrint('Gravação dos dados do usuário foi abortada');
      }
      return categorias;
    }
  }
}
