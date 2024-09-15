import 'package:acervo/models/desejo.dart';
import 'package:acervo/utils/exceptions/my_firebase_auth_exceptions.dart';
import 'package:acervo/utils/exceptions/my_firebase_exceptions.dart';
import 'package:acervo/utils/exceptions/my_platform_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class DesejoServices {
  //obter uma referência (instância) do firebase (cloudfirestore)
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //Obter referência da coleção no firebase
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('desejos');
  Desejo _desejos = Desejo();
  //método para persistir dados no firebase
  // Future<bool> addDesejo({Desejo? desejo}) async {
  //   try {
  //     final doc = await _firestore.collection('desejos').add(desejo!.toMap());
  //     _desejos = desejo;
  //     _desejos.id = doc.id;
  //     return Future.value(true);
  //   } on FirebaseException catch (e) {
  //     debugPrint(e.code.toString());
  //     return Future.value(false);
  //   }
  // }

  Future<bool> addDesejo({Desejo? desejo}) async {
    try {
      // Cria um documento com um ID gerado automaticamente
      final docRef = _firestore.collection('desejos').doc();

      // Atribui o ID gerado ao objeto 'desejo'
      desejo!.id = docRef.id;

      // Grava o desejo no Firestore usando o ID gerado
      await docRef.set(desejo.toMap());

      // Atualiza o desejo na instância local, se necessário
      _desejos = desejo;

      return Future.value(true);
    } on FirebaseException catch (e) {
      debugPrint(e.code.toString());
      return Future.value(false);
    }
  }

  Stream<QuerySnapshot> getDesejos() {
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

  Stream<QuerySnapshot> getDesejosByDate() {
    final Timestamp now = Timestamp.fromDate(DateTime.now());
    final Timestamp yesterday = Timestamp.fromDate(
      DateTime.now().subtract(const Duration(days: 1)),
    );

//ajustar data
    return _collectionRef
        .where('createdAt', isLessThan: now, isGreaterThan: yesterday)
        .orderBy('desejos')
        .snapshots();
  }

  // Future updateDesejo(Desejo desejo) async {
  //   return _firestore.collection('desejos').doc(desejo.id).set(desejo.toMap());
  // }

  // Future updateDesejo(Desejo desejo) async {
  //   try {
  //     // Atualize o documento com o ID especificado
  //     await _firestore.collection('desejos').doc(desejo.id).set(desejo.toMap());
  //     return true;
  //   } catch (e) {
  //     print('Erro ao atualizar desejo: $e');
  //     return false;
  //   }
  // }

  // Método para atualizar um desejo
  Future<bool> updateDesejo(Desejo desejo) async {
    try {
      if (desejo.id == null || desejo.id!.isEmpty) {
        print('ID do desejo não definido');
        return false;
      }

      await _firestore
          .collection('desejos')
          .doc(desejo.id)
          .update(desejo.toMap());
      return true;
    } catch (e) {
      print('Erro ao atualizar desejo: $e');
      return false;
    }
  }

// Método para carregar um desejo para edição
  // Future<Desejo?> getDesejoById(String id) async {
  //   var doc = await _firestore.collection('desejos').doc(id).get();
  //   if (doc.exists) {
  //     var data = doc.data();
  //     return Desejo.fromMap(data!);
  //   }
  //   return null;
  // }

  Future deleteDesejo(String id) async {
    return _firestore.collection('desejos').doc(id).delete();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllDesejos(
      String searchKey) async {
    var data = await _firestore
        .collection('desejos')
        .where('categoria', isGreaterThanOrEqualTo: searchKey)
        .where('categoria', isLessThan: '${searchKey}z')
        .orderBy('categoria')
        .get();
    return data;
  }

  Stream<QuerySnapshot> getItem2(String? searchKey) {
    return _collectionRef
        .orderBy('desejos')
        .where('categoria', isGreaterThanOrEqualTo: searchKey)
        .where('categoria', isLessThan: '${searchKey!}z')
        .orderBy('categoria')
        .snapshots();
  }

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
}
