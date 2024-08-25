import 'package:acervo/models/item.dart';
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
      FirebaseFirestore.instance.collection('item');
  Item _item = Item();
  //método para persistir dados no firebase
  Future<bool> addItem({Item? item}) async {
    try {
      final doc = await _firestore.collection('item').add(item!.toMap());
      _item = item;
      _item.id = doc.id;
      return Future.value(true);
    } on FirebaseException catch (e) {
      debugPrint(e.code.toString());
      return Future.value(false);
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
        .orderBy('item')
        .snapshots();
  }

  Future updateItem(Item item) async {
    return _firestore.collection('item').doc(item.id).set(item.toMap());
  }

  Future deleteQuote(String id) async {
    return _firestore.collection('item').doc(id).delete();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllItem(
      String searchKey) async {
    var data = await _firestore
        .collection('item')
        .where('categoria', isGreaterThanOrEqualTo: searchKey)
        .where('categoria', isLessThan: '${searchKey}z')
        .orderBy('categoria')
        .get();
    return data;
  }

  Stream<QuerySnapshot> getItem2(String? searchKey) {
    return _collectionRef
        .orderBy('region')
        .where('categoria', isGreaterThanOrEqualTo: searchKey)
        .where('categoria', isLessThan: '${searchKey!}z')
        .orderBy('categoria')
        .snapshots();
  }

  //método para obter dados da commodity no firebase
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
    // debugPrint('commodity -> ${listCommodities[0].toString()}');
    return listCategoria;
  }
}
