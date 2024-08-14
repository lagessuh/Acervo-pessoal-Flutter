import 'dart:convert';

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

  UserLocal({this.id, this.userName, this.password, this.email});

  //método para converter dados deste objeto (UserLocal) em
  //formato compatível com o JSON (Firebase)
  Map<String, dynamic> toJsonUser() {
    return {
      'id': id,
      'userName': userName,
      'password': password,
      'email': email,
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
    );
  }

  // String toJson() => json.encode(toMap());

  factory UserLocal.fromJson(String source) =>
      UserLocal.fromMap(json.decode(source));

  UserLocal copyWith({
    String? id,
    String? userName,
    String? password,
    String? email,
  }) {
    return UserLocal(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      email: email ?? this.email,
    );
  }

  UserLocal.fromJson2(Map<String, dynamic> json)
      : userName = json['userName'] as String,
        email = json['email'] as String;

  Map<String, dynamic> toJson2() => {
        'name': userName,
        'email': email,
      };
}
