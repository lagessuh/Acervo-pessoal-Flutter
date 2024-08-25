// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:commodities/models/quote.dart';
// import 'package:commodities/utils/exceptions/my_firebase_auth_exceptions.dart';
// import 'package:commodities/utils/exceptions/my_firebase_exceptions.dart';
// import 'package:commodities/utils/exceptions/my_platform_exceptions.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class AcervoServices {
//   //obter uma referência (instância) do firebase (cloudfirestore)
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   //Obter referência da coleção no firebase
//   final CollectionReference _collectionRef =
//       FirebaseFirestore.instance.collection('quotes');
//   Quote _quotes = Quote();
//   //método para persistir dados no firebase
//   Future<bool> addQuote({Quote? quote}) async {
//     try {
//       final doc = await _firestore.collection('quotes').add(quote!.toMap());
//       _quotes = quote;
//       _quotes.id = doc.id;
//       return Future.value(true);
//     } on FirebaseException catch (e) {
//       debugPrint(e.code.toString());
//       return Future.value(false);
//     }
//   }

//   Stream<QuerySnapshot> getQuotes() {
//     try {
//       return _collectionRef.orderBy('date').snapshots();
//     } on FirebaseAuthException catch (e) {
//       throw MyFirebaseAuthExceptions(e.code).message;
//     } on FirebaseException catch (e) {
//       throw MyFirebaseExceptions(e.code).message;
//     } on PlatformException catch (e) {
//       throw MyPlatformExceptions(e.code).message;
//     } catch (e) {
//       if (kDebugMode)
//         debugPrint('Algo está errado. Por favor, tente novamente');
//       rethrow;
//     }
//   }

//   Stream<QuerySnapshot> getQuotesByDate() {
//     final Timestamp now = Timestamp.fromDate(DateTime.now());
//     final Timestamp yesterday = Timestamp.fromDate(
//       DateTime.now().subtract(const Duration(days: 1)),
//     );

//     return _collectionRef
//         .where('createdAt', isLessThan: now, isGreaterThan: yesterday)
//         .orderBy('quotes')
//         .snapshots();
//   }

//   Future updateQuote(Quote quote) async {
//     return _firestore.collection('quotes').doc(quote.id).set(quote.toMap());
//   }

//   Future deleteQuote(String id) async {
//     return _firestore.collection('quotes').doc(id).delete();
//   }

//   Future<QuerySnapshot<Map<String, dynamic>>> getAllQuotes(
//       String searchKey) async {
//     var data = await _firestore
//         .collection('quotes')
//         .where('region', isGreaterThanOrEqualTo: searchKey)
//         .where('region', isLessThan: '${searchKey}z')
//         .orderBy('region')
//         .get();
//     return data;
//   }

//   Stream<QuerySnapshot> getQuotes2(String? searchKey) {
//     return _collectionRef
//         .orderBy('region')
//         .where('region', isGreaterThanOrEqualTo: searchKey)
//         .where('region', isLessThan: '${searchKey!}z')
//         .orderBy('region')
//         .snapshots();
//   }

//   //método para obter dados da commodity no firebase
//   Future<List> searchQuoteByRegion(String region) async {
//     List listRegions = [];
//     final result = await _collectionRef
//         .where(
//           'region',
//           isGreaterThanOrEqualTo: region,
//           isLessThan: '${region}z',
//         )
//         .get();
//     listRegions = result.docs.map((e) => e.data()).toList();
//     // debugPrint('commodity -> ${listCommodities[0].toString()}');
//     return listRegions;
//   }
// }
