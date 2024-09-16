//classe para transferência de dados entre camada de visão, RN e entidades
//DTO => Data Transfer Object

//id, genero

//método construtor
import 'package:acervo/models/userlocal.dart';

class Genero {
  String? id;
  String? nome;
  UserLocal? userlocal = UserLocal();
  Genero({
    this.id,
    this.nome,
    this.userlocal,
  });

  Genero copyWith({
    String? id,
    String? nome,
    UserLocal? userlocal,
  }) {
    return Genero(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      userlocal: userlocal ?? this.userlocal,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'userlocal': userlocal?.toJsonUser(),
    };
  }

  Map<String, dynamic> toMapGeneroItem() {
    return {
      'id': id,
      'nome': nome,
      'userlocal': userlocal?.toJsonUser(),
    };
  }

  Genero.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nome = json['nome'];

  factory Genero.fromMap(Map<String, dynamic> map) {
    return Genero(
      id: map['id'] != null ? map['id'] as String : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
      userlocal: map['userlocal'] != null
          ? UserLocal.fromMap(map['userlocal'] as Map<String, dynamic>)
          : null,
    );
  }

  ///this method will prevent the override of toString
  String generoAsString() {
    return '#$id $nome';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(Genero model) {
    return id == model.id;
  }

  @override
  String toString() => nome!;
}
