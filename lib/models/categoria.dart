//classe para transferência de dados entre camada de visão, RN e entidades
//DTO => Data Transfer Object
import 'dart:convert';

import 'package:acervo/models/userlocal.dart';
import 'package:flutter/foundation.dart';

class Categoria {
  String? id;
  String? nome;
  UserLocal? userlocal = UserLocal();

  //id, categoria

  //método construtor
  Categoria({
    this.id,
    this.nome,
    this.userlocal,
  });

  Categoria copyWith({
    String? id,
    String? nome,
    UserLocal? userlocal,
  }) {
    return Categoria(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      userlocal: userlocal ?? this.userlocal,
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'nome': nome,
  //   };
  // }

  Map<String, dynamic> toMapCategoria() {
    return {
      'id': id,
      'nome': nome,
      'userlocal': userlocal?.toJsonUser(),
    };
  }

  Map<String, dynamic> toMapCategoriaDesejos() {
    return {
      'id': id,
      'nome': nome,
      'userlocal': userlocal?.toJsonUser(),
    };
  }

  // Categoria.fromJson(Map<String, dynamic> json)
  //     : id = json['id'],
  //       nome = json['nome'];

  factory Categoria.fromMap(Map<String, dynamic> map) {
    return Categoria(
      id: map['id'] != null ? map['id'] as String : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
      userlocal: map['userlocal'] != null
          ? UserLocal.fromMap(map['userlocal'] as Map<String, dynamic>)
          : null,
    );
  }

  factory Categoria.fromMap2(Map<String, dynamic> map) {
    return Categoria(
      id: map['id'],
      nome: map['nome'],
    );
  }

  String toJson() => json.encode(toMapCategoriaDesejos());
  factory Categoria.fromJson(String source) =>
      Categoria.fromMap(json.decode(source));
  factory Categoria.fromJson2(String source) =>
      Categoria.fromMap2(json.decode(source));

  ///this method will prevent the override of toString
  String categoriaAsString() {
    return '#$id $nome';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(Categoria model) {
    return id == model.id;
  }

  @override
  String toString() => nome!;
}
