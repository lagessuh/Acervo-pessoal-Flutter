import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

//id, nome, email, senha, status

//classe a ser utilizada para transferência de dados do usuário
@HiveType(typeId: 1)
@JsonSerializable()
class UserLocal {
//definir variáveis de instância para representar
//os dados do usuário
  @HiveField(0)
  @JsonKey(name: 'id')
  String? id;
  @HiveField(1)
  @JsonKey(name: 'userName')
  String? userName;
  @HiveField(2)
  @JsonKey(name: 'password')
  String? password;
  @HiveField(3)
  @JsonKey(name: 'email')
  String? email;
  // @HiveField(4)
  // @JsonKey(name: 'phone')
  //String? phone;
  @HiveField(4)
  @JsonKey(name: 'categorias')
  List<Map<String, dynamic>>? categorias;
  @HiveField(5)
  @JsonKey(name: 'generos')
  List<Map<String, dynamic>>? generos;
  @HiveField(6)
  @JsonKey(name: 'aquisicoes')
  List<Map<String, dynamic>>? aquisicoes;
  @HiveField(7)
  @JsonKey(name: 'itens')
  List<Map<String, dynamic>>? itens;
  @HiveField(8)
  @JsonKey(name: 'desejos')
  List<Map<String, dynamic>>? desejos;

  UserLocal(
      {this.id,
      this.userName,
      this.password,
      this.email,
      this.generos,
      this.categorias,
      this.aquisicoes,
      this.itens,
      this.desejos});
  bool isLogged = false;

  //método para converter dados deste objeto (UserLocal) em
  //formato compatível com o JSON (Firebase)
  Map<String, dynamic> toJsonUser() {
    return {
      'id': id,
      'userName': userName,
      'password': password,
      'email': email,
      'generos': generos,
      'categorias': categorias,
      'aquisicoes': aquisicoes,
      'itens': itens,
      'desejos': desejos,
    };
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (userName != null) {
      result.addAll({'userName': userName});
    }
    if (password != null) {
      result.addAll({'password': password});
    }
    if (email != null) {
      result.addAll({'email': email});
    }

    return result;
  }

  factory UserLocal.fromMap(Map<String, dynamic> map) {
    return UserLocal(
      id: map['id'],
      userName: map['userName'],
      password: map['password'],
      email: map['email'],
      generos: map['generos'] is Iterable ? List.from(map['generos']) : null,
      categorias:
          map['categorias'] is Iterable ? List.from(map['categorias']) : null,
      aquisicoes:
          map['aquisicoes'] is Iterable ? List.from(map['aquisicoes']) : null,
      itens: map['itens'] is Iterable ? List.from(map['itens']) : null,
      desejos: map['desejos'] is Iterable ? List.from(map['desejos']) : null,
    );
  }

  Map<String, dynamic> toJsonItem() {
    return {
      'id': id,
      'userName': userName,
    };
  }

  factory UserLocal.fromJson(String source) =>
      UserLocal.fromMap(json.decode(source));

  UserLocal copyWith(
      {String? id,
      String? userName,
      String? password,
      String? email,
      List<Map<String, dynamic>>? generos,
      List<Map<String, dynamic>>? categorias,
      List<Map<String, dynamic>>? aquisicoes,
      List<Map<String, dynamic>>? itens,
      List<Map<String, dynamic>>? desejos}) {
    return UserLocal(
        id: id ?? this.id,
        userName: userName ?? this.userName,
        password: password ?? this.password,
        email: email ?? this.email,
        generos: generos ?? this.generos,
        categorias: categorias ?? this.categorias,
        aquisicoes: aquisicoes ?? this.aquisicoes,
        itens: itens ?? this.itens,
        desejos: desejos ?? this.desejos);
  }

  UserLocal.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    userName = doc.get('userName') as String;
    email = doc.get('email') as String;
    generos =
        doc.get('generos') is Iterable ? List.from(doc.get('generos')) : null;
    categorias = doc.get('categorias') is Iterable
        ? List.from(doc.get('categorias'))
        : null;
    aquisicoes = doc.get('aquisicoes') is Iterable
        ? List.from(doc.get('aquisicoes'))
        : null;
    itens = doc.get('itens') is Iterable ? List.from(doc.get('itens')) : null;
    desejos =
        doc.get('desejos') is Iterable ? List.from(doc.get('desejos')) : null;
  }

  UserLocal.fromJson2(Map<String, dynamic> json)
      : userName = json['userName'] as String,
        email = json['email'] as String,
        generos =
            json['generos'] is Iterable ? List.from(json['generos']) : null,
        aquisicoes = json['aquisicoes'] is Iterable
            ? List.from(json['aquisicoes'])
            : null,
        categorias = json['categorias'] is Iterable
            ? List.from(json['categorias'])
            : null,
        itens = json['itens'] is Iterable ? List.from(json['itens']) : null,
        desejos =
            json['desejos'] is Iterable ? List.from(json['desejos']) : null;

  Map<String, dynamic> toJson2() => {
        'userName': userName,
        'email': email,
        'generos': generos,
        'categorias': categorias,
        'aquisicoes': aquisicoes,
        'itens': itens,
        'desejos': desejos,
      };
}
