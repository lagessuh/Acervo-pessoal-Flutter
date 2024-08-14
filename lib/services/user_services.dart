import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:acervo/models/userlocal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserServices {
  //Widget para autenticação do usuário
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //Widget para persistência do dados do usuário
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final UserLocal _userLocal = UserLocal();

  //método do tipo get para obter uma referência da coleção no firebase
  CollectionReference get _collectionRef => _firestore.collection('users');

  //método para obter a referência do documento no firebase
  DocumentReference get _docRef => _firestore.doc('users/${_userLocal.id!}');

  //método de registro de usuário no Firebase
  signUp(String userName, String email, String password) async {
    User? user = (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;

    _userLocal.id = user!.uid;
    _userLocal.email = user.email;
    _userLocal.userName = userName;

    saveData();
  }

  //método para realizar a autenticação do usuário
  Future<bool> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      final user = _auth.currentUser;

      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('Não há usuário registrado com este email');
      } else if (e.code == 'wrong-password') {
        debugPrint('A senha informada não confere');
      } else if (e.code == 'invalid-email') {
        debugPrint('O email informado está com formato inválido');
      } else if (e.code == 'user-disabled') {
        debugPrint('Email do usuário está desabilitado');
      }
      return Future.value(false);
    }
  }

  Future<bool> logout() async {
    try {
      await _auth.signOut();
      return Future.value(true);
    } on FirebaseException {
      return Future.value(false);
    }
  }

  //Método para persistir dados do usuário no firebase firestore
  saveData() {
    _docRef.set(_userLocal.toJson2());
  }
}
