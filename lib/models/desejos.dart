// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:acervo/models/categoria.dart';
//import 'package:flutter/material.dart';

class Desejos {
  String? id;
  String? nome;
  String? autor;
  Categoria? categoria = Categoria();
  DateTime? data;
  String? status;
  //Group({
  // required this.id,
  // required this.description,
  // required this.type,
  //});

  //id, nome, autor, genero, data, atendido

  //-- método construtor
  Desejos(
      {this.id, this.nome, this.autor, this.categoria, this.data, this.status});

  Desejos copyWith(
      {String? id,
      String? nome,
      String? autor,
      Categoria? categoria,
      DateTime? data,
      String? status}) {
    return Desejos(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      autor: autor ?? this.autor,
      categoria: categoria ?? this.categoria,
      data: data ?? this.data,
      status: status ?? this.status,
    );
  }

  //-- utilizado para enviar dados para o firebase com formato compatível com o JSON (map)
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': nome,
      'author': autor,
      'categoria': categoria?.toJsonCategoria(),
      'date': data?.toIso8601String(),
      'status': status,
    };
  }

  //-- método que converte dados no formato JSON para o objeto Quote
  factory Desejos.fromMap(Map<String, dynamic> map) {
    return Desejos(
      id: map['id'] != null ? map['id'] as String : null,
      categoria: map['categoria'] != null
          ? Categoria.fromMap(map['categoria'] as Map<String, dynamic>)
          : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
      autor: map['autor'] != null ? map['autor'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      data: map['data'] != null ? map['data'] as DateTime : null,
    );
  }

  //factory Group.fromMap(Map<String, dynamic> map) {
  // return Group(
  // id: map['id'] ?? '',
  // description: map['description'] ?? '',
  //  type: map['type'] ?? '',
  // );
  // }

  //verificar linha depois
  static List<Desejos> fromJsonList(List list) {
    return list.map((item) => Desejos.fromJson(item)).toList();
  }

  String toJson() => json.encode(toMap());

  factory Desejos.fromJson(String source) =>
      Desejos.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'WishList(id: $id, name: $nome, author: $autor, categories: $categoria, date: $data, status: $status)';

  @override
  bool operator ==(covariant Desejos other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nome == nome &&
        other.autor == autor &&
        other.categoria == categoria &&
        other.status == status &&
        other.data == data;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      nome.hashCode ^
      autor.hashCode ^
      categoria.hashCode ^
      data.hashCode ^
      status.hashCode;
}
