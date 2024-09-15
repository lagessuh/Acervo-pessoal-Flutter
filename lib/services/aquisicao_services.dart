import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:acervo/models/aquisicao.dart';
import 'package:flutter/cupertino.dart';

class AquisicaoServices {
  //obter uma referência (instância) do firebase (cloudfirestore)
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //Obter referência da coleção no firebase
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('aquisicoes');
  Aquisicao _aquisicoes = Aquisicao();
  //método para persistir dados no firebase
  // Future<bool> addAquisicao({Aquisicao? aquisicao}) async {
  //   try {
  //     final doc = await _firestore
  //         .collection('aquisicoes')
  //         .add(aquisicao!.toMapAquisicaoItem());
  //     _aquisicoes = aquisicao;
  //     _aquisicoes.id = doc.id;
  //     return Future.value(true);
  //   } on FirebaseException catch (e) {
  //     debugPrint(e.code.toString());
  //     return Future.value(false);
  //   }
  // }

  Future<bool> addAquisicao({Aquisicao? aquisicao}) async {
    try {
      // Cria um documento com um ID gerado automaticamente
      final docRef = _firestore.collection('aquisicoes').doc();

      // Atribui o ID gerado ao objeto 'aquisicao'
      aquisicao!.id = docRef.id;

      // Grava a aquisição no Firestore usando o ID gerado
      await docRef.set(aquisicao.toMapAquisicaoItem());

      // Atualiza a instância local, se necessário
      _aquisicoes = aquisicao;

      return Future.value(true);
    } on FirebaseException catch (e) {
      debugPrint(e.code.toString());
      return Future.value(false);
    }
  }

  Stream<QuerySnapshot> getAquisicoes() {
    return _collectionRef.orderBy('nome').snapshots();
  }

  Future updateAquisicao(Aquisicao aquisicoes) async {
    return _firestore
        .collection('aquisicoes')
        .doc(aquisicoes.id)
        .set(aquisicoes.toMapAquisicaoItem());
  }

  Future deleteAquisicao(String id) async {
    return _firestore.collection('aquisicoes').doc(id).delete();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllAquisicoes(
      String searchKey) async {
    var data = await _firestore
        .collection('aquisicoes')
        .where('nome', isGreaterThanOrEqualTo: searchKey)
        .where('nome', isLessThan: '${searchKey}z')
        .orderBy('nome')
        .get();
    return data;
  }

  Stream<QuerySnapshot> getAquisicao2(String? searchKey) {
    return _collectionRef
        .orderBy('nome')
        .where('nome', isGreaterThanOrEqualTo: searchKey)
        .where('nome', isLessThan: '${searchKey!}z')
        .orderBy('nome')
        .snapshots();
  }

  //método para obter dados da Aquisicao no firebase
  Future<List> searchAquisicaoByName(String nome) async {
    List<DocumentSnapshot> docs = [];
    List listAquisicoes = [];
    final result = await _collectionRef
        .where(
          'nome',
          isGreaterThanOrEqualTo: nome,
          isLessThan: '${nome}z',
        )
        .get();
    listAquisicoes = result.docs.map((e) => e.data()).toList();
    return listAquisicoes;
  }

  Future<List<Aquisicao>> getAllAquisicoesItem(String filter) async {
    QuerySnapshot querySnapshot = await _collectionRef.orderBy('nome').get();
    return querySnapshot.docs.map((doc) {
      return Aquisicao(
        id: doc.id,
        nome: doc['nome'],
      );
    }).toList();
  }
}
