import 'package:acervo/services/categoria_services.dart';
import 'package:acervo/utils/exceptions/my_firebase_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:acervo/models/userlocal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UserServices extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  UserLocal? userLocal = UserLocal();

  CollectionReference get _collectionRef => _firestore.collection('users');
  DocumentReference get _docRef => _firestore.doc('users/${userLocal!.id!}');

  UserServices() {
    _loadingCurrentUser();
  }

  UserLocal? get getUser => userLocal;
  // Future<bool> signUp({
  //   required String userName,
  //   required String email,
  //   required String password,
  //   Function? onFail,
  //   Function? onSuccess,
  // }) async {
  //   try {
  //     UserCredential userCredential =
  //         await _auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );

  //     User? user = userCredential.user;
  //     if (user != null) {
  //       UserLocal newUserLocal = UserLocal(
  //         id: user.uid,
  //         userName: userName,
  //         email: email,
  //         generos: [],
  //         categorias: [],
  //         aquisicoes: [],
  //         itens: [],
  //         desejos: [],
  //       );
  //       await saveData(newUserLocal); // Ensure saveData() is awaited

  //       // Load current user data
  //       await _loadingCurrentUser(user: user);
  //       if (onSuccess != null) onSuccess();
  //       return true;
  //     } else {
  //       if (onFail != null) onFail('Failed to create user.');
  //       return false;
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     if (onFail != null) {
  //       switch (e.code) {
  //         case 'user-not-found':
  //           onFail('Não há usuário registrado com este email');
  //           break;
  //         case 'wrong-password':
  //           onFail('A senha informada não confere');
  //           break;
  //         case 'invalid-email':
  //           onFail('O email informado está com formato inválido');
  //           break;
  //         case 'user-disabled':
  //           onFail('Email do usuário está desabilitado');
  //           break;
  //         default:
  //           onFail('Erro ao criar conta: ${e.message}');
  //       }
  //     }
  //     return false;
  //   } catch (e) {
  //     if (onFail != null) onFail('Erro inesperado: $e');
  //     return false;
  //   }
  // }

  Future<bool> signUp(
      {UserLocal? userLocal,
      String? userName,
      String? email,
      String? password,
      Function? onFail,
      Function? onSuccess}) async {
    try {
      User? user = (await _auth.createUserWithEmailAndPassword(
        email: userLocal!.email!,
        password: password!,
      ))
          .user;
      this.userLocal = userLocal;
      this.userLocal!.id = user!.uid;
      saveData();

      _loadingCurrentUser(user: user);
      onSuccess!();
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        onFail!('Não há usuário registrado com este email');
      } else if (e.code == 'wrong-password') {
        onFail!('A senha informada não confere');
      } else if (e.code == 'invalid-email') {
        onFail!('O email informado está com formato inválido');
      } else if (e.code == 'user-disabled') {
        onFail!('Email do usuário está desabilitado');
      }
      return Future.value(false);
    }
  }

  // Future<bool> signUp({
  //   UserLocal? userLocal,
  //   String? userName,
  //   String? email,
  //   String? password,
  //   Function? onFail,
  //   Function? onSuccess,
  // }) async {
  //   try {
  //     // Cria o usuário no Firebase Authentication
  //     User? user = (await _auth.createUserWithEmailAndPassword(
  //       email: userLocal!.email!, // usa o email do userLocal
  //       password: password!, // usa a senha fornecida
  //     ))
  //         .user;

  //     // // Atribui o UID gerado pelo Firebase Auth ao userLocal.id
  //     // this.userLocal = userLocal;
  //     // this.userLocal!.id =
  //     //     user!.uid; // aqui o id do Firebase Auth é salvo em userLocal
  //     // Define o ID gerado no objeto 'genero'
  //     final docRef = _firestore.collection('users').doc();
  //     userLocal!.id = docRef.id;

  //     // Grava o objeto no Firestore com o ID gerado
  //     await docRef.set(userLocal.toMap());
  //     // Chama o método saveData e aguarda a conclusão
  //     bool success = await saveData(); // Aguarda o salvamento no Firestore

  //     if (success) {
  //       // Carrega o usuário atual
  //       _loadingCurrentUser(user: user);

  //       // Chama a função de sucesso
  //       onSuccess!();

  //       return true; // Retorna true se tudo der certo
  //     } else {
  //       // Se houver erro ao salvar, retorna false
  //       onFail!("Erro ao salvar dados do usuário");
  //       return false;
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     // Trata os possíveis erros do FirebaseAuthException
  //     if (e.code == 'user-not-found') {
  //       onFail!('Não há usuário registrado com este email');
  //     } else if (e.code == 'wrong-password') {
  //       onFail!('A senha informada não confere');
  //     } else if (e.code == 'invalid-email') {
  //       onFail!('O email informado está com formato inválido');
  //     } else if (e.code == 'user-disabled') {
  //       onFail!('Email do usuário está desabilitado');
  //     }
  //     return false;
  //   }
  // }

  // Future<bool> signUp({
  //   UserLocal? userLocal,
  //   String? userName,
  //   String? email,
  //   String? password,
  //   Function? onFail,
  //   Function? onSuccess,
  // }) async {
  //   try {
  //     // Cria o usuário no Firebase Authentication
  //     User? user = (await _auth.createUserWithEmailAndPassword(
  //       email: userLocal!.email!, // usa o email do userLocal
  //       password: password!, // usa a senha fornecida
  //     ))
  //         .user;

  //     // Salva o UID gerado pelo Firebase Auth no campo 'id' do userLocal
  //     this.userLocal = userLocal;
  //     this.userLocal!.id = user!.uid;

  //     // Define o ID gerado para o documento no Firestore (diferente do UID do Firebase)
  //     final docRef = _firestore
  //         .collection('users')
  //         .doc(); // Gera um novo ID para o documento no Firestore

  //     // Armazena o UID do Firebase no campo 'id' do documento no Firestore
  //     userLocal!.id = user.uid;

  //     // Grava o objeto no Firestore com o ID gerado (diferente do UID)
  //     await docRef.set(userLocal.toMap());

  //     // Chama a função de sucesso
  //     onSuccess!();

  //     return true; // Retorna true se tudo der certo
  //   } on FirebaseAuthException catch (e) {
  //     // Trata os possíveis erros do FirebaseAuthException
  //     if (e.code == 'user-not-found') {
  //       onFail!('Não há usuário registrado com este email');
  //     } else if (e.code == 'wrong-password') {
  //       onFail!('A senha informada não confere');
  //     } else if (e.code == 'invalid-email') {
  //       onFail!('O email informado está com formato inválido');
  //     } else if (e.code == 'user-disabled') {
  //       onFail!('Email do usuário está desabilitado');
  //     }
  //     return false;
  //   }
  // }

  signIn(
      {String? email,
      String? password,
      Function? onFail,
      Function? onSuccess}) async {
    try {
      final User? user = (await _auth.signInWithEmailAndPassword(
              email: email!, password: password!))
          .user;
      _loadingCurrentUser(user: user);
      onSuccess!();
    } on FirebaseAuthException catch (e) {
      String fail;
      if (e.code == 'user-not-found') {
        fail = ('Não há usuário registrado com este email');
      } else if (e.code == 'wrong-password') {
        fail = ('A senha informada não confere');
      } else if (e.code == 'invalid-email') {
        fail = ('O email informado está com formato inválido');
      } else if (e.code == 'user-disabled') {
        fail = ('Email do usuário está desabilitado');
      } else {
        fail = 'Algo na autenticação aconteceu de errado';
      }
      onFail!(fail);
    }
  }

  Future<bool> logOut() async {
    try {
      await _auth.signOut();
      return Future.value(true);
    } on FirebaseException {
      return Future.value(false);
    }
  }

  // Future<void> saveData(UserLocal userLocal) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(userLocal.id)
  //         .set(userLocal.toJson2());
  //   } catch (e) {
  //     print('Erro ao salvar dados do usuário: $e');
  //   }
  // }
  // Future<bool> saveData() async {
  //   try {
  //     await _docRef.set(userLocal!.toJson2());
  //     return true;
  //   } catch (e) {
  //     debugPrint('Erro ao salvar dados: $e');
  //     return false;
  //   }
  // }
  Future<bool> saveData() async {
    try {
      final _docRef = FirebaseFirestore.instance.collection('users').doc(
          userLocal!
              .id); // Usando o id do userLocal para referenciar o documento

      await _docRef.set(userLocal!.toJson2()); // Salva os dados

      return true; // Retorna true se os dados forem salvos com sucesso
    } catch (e) {
      debugPrint('Erro ao salvar dados: $e');
      return false; // Retorna false se houver erro
    }
  }

//Método para persistir dados do usuário no firebase firestore
  updateData(
      {UserLocal? userLocal, Function? onFail, Function? onSuccess}) async {
    this.userLocal!.id = userLocal!.id;
    debugPrint('atualizando dados do usuário ${userLocal.toString()}');
    //${userLocal.categorias.toString()}
    try {
      // await _docRef.set(userLocal.toJson());
      await _firestore
          .collection('users')
          .doc(userLocal.id)
          .set(userLocal.toJsonUser());
      final DocumentSnapshot docUser =
          await _firestore.collection('users').doc(this.userLocal!.id).get();

      userLocal = UserLocal.fromDocument(docUser);
      notifyListeners();
      onSuccess!();
    } on MyFirebaseExceptions catch (e) {
      onFail!(MyFirebaseExceptions(e.code));
    }
  }

//   //Método para persistir dados do usuário no firebase firestore
//   updateCategoriasData(
//       {UserLocal? userLocal, Function? onFail, Function? onSuccess}) async {
//     this.userLocal!.id = userLocal!.id;
//     try {
//       // await _docRef.update(userLocal.toJson());
//       _firestore
//           .collection('users')
//           .doc(userLocal.id)
//           .collection('categorias')
//           .add({
//         'categorias': FieldValue.arrayUnion(userLocal.categorias!),
//       });
//       final DocumentSnapshot docUser =
//           await _firestore.collection('users').doc(this.userLocal!.id).get();

//       userLocal = UserLocal.fromDocument(docUser);
//       notifyListeners();
//       onSuccess!();
//     } on MyFirebaseExceptions catch (e) {
//       onFail!(MyFirebaseExceptions(e.code));
//     }
//   }

  //--obter usuário conectado
  // Future<void> _loadingCurrentUser({User? user}) async {
  //   final User? currentUser = user ?? _auth.currentUser;
  //   if (currentUser != null && !currentUser.isAnonymous) {
  //     try {
  //       // final DocumentSnapshot docUser = await _firestore.collection('users').doc(currentUser.uid).get();
  //       final DocumentSnapshot docUser =
  //           await _collectionRef.doc(currentUser.uid).get();
  //       userLocal = UserLocal.fromDocument(docUser);
  //       notifyListeners();
  //     } on FirebaseAuthException catch (e) {
  //       if (e.code == 'user-not-found') {
  //         debugPrint('Não há usuário registrado com este email');
  //       } else if (e.code == 'wrong-password') {
  //         debugPrint('A senha informada não confere');
  //       } else if (e.code == 'invalid-email') {
  //         debugPrint('O email informado está com formato inválido');
  //       } else if (e.code == 'user-disabled') {
  //         debugPrint('Email do usuário está desabilitado');
  //       }
  //     }
  //   } else {
  //     debugPrint('usuário ainda não autenticado');
  //   }
  // }

  Future<void> _loadingCurrentUser({User? user}) async {
    final User? currentUser = user ?? _auth.currentUser;

    if (currentUser != null && !currentUser.isAnonymous) {
      try {
        final DocumentSnapshot docUser =
            await _collectionRef.doc(currentUser.uid).get();

        if (docUser.exists) {
          userLocal = UserLocal.fromDocument(docUser);
          notifyListeners();
        } else {
          debugPrint('Usuário não encontrado no Firestore');
        }
      } catch (e) {
        debugPrint('Erro ao carregar dados do usuário: $e');
      }
    } else {
      debugPrint('Usuário ainda não autenticado ou é anônimo');
    }
  }

  void signOut() {
    _auth.signOut();
    userLocal = null;
    notifyListeners();
  }

  // Future<List<Map<String, dynamic>>> getUserCategorias(
  //     UserLocal userlocal) async {
  //   List<Map<String, dynamic>> categorias = <Map<String, dynamic>>[];
  //   var doc;
  //   try {
  //     await _firestore
  //         .collection('users')
  //         .doc(userLocal!.id)
  //         .get()
  //         .then((value) async {
  //       doc = value.data()!;
  //       if (doc['categorias'] != null) {
  //         List.from(doc['categorias']).forEach((categoria) {
  //           categorias.add(categoria);
  //         });
  //       } else {
  //         CategoriaServices categoriaServices = CategoriaServices();
  //         dynamic categoriasUser = await categoriaServices.getCategoriaToUser();
  //         categorias = categoriasUser;

  //         return categoriasUser;
  //       }
  //     });

  //     return categorias;
  //   } on FirebaseException catch (e) {
  //     if (e.code != 'OK') {
  //       debugPrint('Problemas ao gravar dados do usuário com a imagem');
  //     } else if (e.code == 'ABORTED') {
  //       debugPrint('Gravação dos dados do usuário foi abortada');
  //     }
  //     return categorias;
  //   }
  // }

  // Adiciona o ID de um item à lista de IDs do usuário
  // Future<void> addItemToUser(String userId, String itemId) async {
  //   try {
  //     await _firestore.collection('users').doc(userId).update({
  //       'itens': FieldValue.arrayUnion([itemId]),
  //     });
  //   } catch (e) {
  //     // Trate o erro aqui
  //     print('Erro ao adicionar item ao usuário: $e');
  //   }
  // }

  // // Adiciona o ID de uma categoria à lista de IDs do usuário
  // Future<void> addCategoriaToUser(String userId, String categoriaId) async {
  //   try {
  //     await _firestore.collection('users').doc(userId).update({
  //       'categorias': FieldValue.arrayUnion([categoriaId]),
  //     });
  //   } catch (e) {
  //     // Trate o erro aqui
  //     print('Erro ao adicionar categoria ao usuário: $e');
  //   }
  // }

  // Adiciona o ID de um desejo à lista de IDs do usuário
  // Future<void> addDesejoToUser(String userId, String desejoId) async {
  //   try {
  //     await _firestore.collection('users').doc(userId).update({
  //       'desejos': FieldValue.arrayUnion([desejoId]),
  //     });
  //   } catch (e) {
  //     // Trate o erro aqui
  //     print('Erro ao adicionar desejo ao usuário: $e');
  //   }
  // }

  // Adiciona o ID de uma aquisição à lista de IDs do usuário
  // Future<void> addAquisicaoToUser(String userId, String aquisicaoId) async {
  //   try {
  //     await _firestore.collection('users').doc(userId).update({
  //       'aquisicoes': FieldValue.arrayUnion([aquisicaoId]),
  //     });
  //   } catch (e) {
  //     // Trate o erro aqui
  //     print('Erro ao adicionar aquisição ao usuário: $e');
  //   }
  // }

  // Remove o ID de um item da lista de IDs do usuário
  // Future<void> removeItemFromUser(String userId, String itemId) async {
  //   try {
  //     await _firestore.collection('users').doc(userId).update({
  //       'itens': FieldValue.arrayRemove([itemId]),
  //     });
  //   } catch (e) {
  //     // Trate o erro aqui
  //     print('Erro ao remover item do usuário: $e');
  //   }
  // }

  // Remove o ID de uma categoria da lista de IDs do usuário
  // Future<void> removeCategoriaFromUser(
  //     String userId, String categoriaId) async {
  //   try {
  //     await _firestore.collection('users').doc(userId).update({
  //       'categorias': FieldValue.arrayRemove([categoriaId]),
  //     });
  //   } catch (e) {
  //     // Trate o erro aqui
  //     print('Erro ao remover categoria do usuário: $e');
  //   }
  // }

  // // Remove o ID de um desejo da lista de IDs do usuário
  // Future<void> removeDesejoFromUser(String userId, String desejoId) async {
  //   try {
  //     await _firestore.collection('users').doc(userId).update({
  //       'desejos': FieldValue.arrayRemove([desejoId]),
  //     });
  //   } catch (e) {
  //     // Trate o erro aqui
  //     print('Erro ao remover desejo do usuário: $e');
  //   }
  // }

  // // Remove o ID de uma aquisição da lista de IDs do usuário
  // Future<void> removeAquisicaoFromUser(
  //     String userId, String aquisicaoId) async {
  //   try {
  //     await _firestore.collection('users').doc(userId).update({
  //       'aquisicoes': FieldValue.arrayRemove([aquisicaoId]),
  //     });
  //   } catch (e) {
  //     // Trate o erro aqui
  //     print('Erro ao remover aquisição do usuário: $e');
  //   }
  // }
}
