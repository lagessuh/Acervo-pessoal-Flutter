import 'package:acervo/models/userlocal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:acervo/models/genero.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class GeneroServices {
  //obter uma referência (instância) do firebase (cloudfirestore)
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //Obter referência da coleção no firebase
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('generos');
  Genero _generos = Genero();
  //método para persistir dados no firebase
  // Future<bool> addGenero({Genero? genero}) async {
  //   try {
  //     final docRef =
  //         await _firestore.collection('generos').add(genero!.toMapGeneroItem());
  //     _generos = genero;
  //     _generos.id = doc.id;
  //     return Future.value(true);
  //   } on FirebaseException catch (e) {
  //     debugPrint(e.code.toString());
  //     return Future.value(false);
  //   }
  // }

  // Future<bool> addGenero({Genero? genero}) async {
  //   try {
  //     // Cria um documento com um ID gerado automaticamente
  //     final docRef = _firestore.collection('generos').doc();
  //     await docRef.set(genero!.toMapGeneroItem());
  //     genero.id = docRef.id;
  //     return Future.value(true);
  //   } on FirebaseException catch (e) {
  //     debugPrint(e.code.toString());
  //     return Future.value(false);
  //   }
  // }

  Future<bool> addGenero({Genero? genero}) async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        // Caso o usuário não esteja logado, retorna false
        print('Usuário não logado');
        return Future.value(false);
      }

      // Preencher o userlocal com os dados do usuário logado
      genero!.userlocal = UserLocal(
        id: currentUser.uid, // ou outro dado relevante
      );

      // Cria um documento com um ID gerado automaticamente
      final docRef = _firestore.collection('generos').doc();

      // Define o ID gerado no objeto 'genero'
      genero!.id = docRef.id;

      // Grava o objeto no Firestore com o ID gerado
      await docRef.set(genero.toMapGeneroItem());

      return Future.value(true);
    } on FirebaseException catch (e) {
      debugPrint(e.code.toString());
      return Future.value(false);
    }
  }

  Stream<QuerySnapshot> getGeneros() {
    return _collectionRef.orderBy('nome').snapshots();
  }

  Future updateGenero(Genero generos) async {
    return _firestore
        .collection('generos')
        .doc(generos.id)
        .set(generos.toMapGeneroItem());
  }

  Future deleteGenero(String id) async {
    return _firestore.collection('generos').doc(id).delete();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllGenero(
      String searchKey) async {
    var data = await _firestore
        .collection('generos')
        .where('nome', isGreaterThanOrEqualTo: searchKey)
        .where('nome', isLessThan: '${searchKey}z')
        .orderBy('nome')
        .get();
    return data;
  }

  Stream<QuerySnapshot> getGenero2(String? searchKey) {
    return _collectionRef
        .orderBy('nome')
        .where('nome', isGreaterThanOrEqualTo: searchKey)
        .where('nome', isLessThan: '${searchKey!}z')
        .orderBy('nome')
        .snapshots();
  }

  //método para obter dados da Aquisicao no firebase
  Future<List> searchGeneroByName(String nome) async {
    List<DocumentSnapshot> docs = [];
    List listGeneros = [];
    final result = await _collectionRef
        .where(
          'nome',
          isGreaterThanOrEqualTo: nome,
          isLessThan: '${nome}z',
        )
        .get();
    listGeneros = result.docs.map((e) => e.data()).toList();
    return listGeneros;
  }

  Future<List<Genero>> getAllGenerosItem(String filter) async {
    QuerySnapshot querySnapshot = await _collectionRef.orderBy('nome').get();
    return querySnapshot.docs.map((doc) {
      return Genero(
        id: doc.id,
        nome: doc['nome'],
      );
    }).toList();
  }
}
