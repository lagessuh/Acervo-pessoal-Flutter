// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:acervo/models/aquisicao.dart';
import 'package:acervo/models/categoria.dart';
import 'package:acervo/models/genero.dart';
import 'package:acervo/models/userlocal.dart';

//id, nome, edicao, autor, tipo, avaliação, ano_lançamento, aquisição, genero, categoria, usuario, data cadastro,
class Item {
  String? id;
  String? nome; //nome do item
  String? edicao; //número da edição
  String? autor; //nome do autor ou desenvolvedor do item
  String? tipo; //se o item é físico ou digital
  String? avaliacao; //avaliação do item
  DateTime? dataLancamento; //data de lançamento
  Aquisicao? aquisicao = Aquisicao(); //local ou forma que o item foi adquirido
  Genero? genero = Genero(); //Gênero do item (ex. ação, terror, romance)...
  Categoria? categoria =
      Categoria(); //Categoria do item(ex. filme, livro, DVDs). Descrição do que ele é
  UserLocal? userlocal = UserLocal(); //usuario que realizou o cadastro
  DateTime? data; //data de cadastro

  //-- método construtor
  Item(
      {this.id,
      this.nome,
      this.edicao,
      this.autor,
      this.tipo,
      this.avaliacao,
      this.dataLancamento,
      this.aquisicao,
      this.genero,
      this.categoria,
      this.userlocal,
      this.data});

  Item copyWith(
      {String? id,
      String? nome,
      String? edicao,
      String? autor,
      String? tipo,
      String? avaliacao,
      DateTime? dataLancamento,
      Aquisicao? aquisicao,
      Genero? genero,
      Categoria? categoria,
      UserLocal? userlocal,
      DateTime? data}) {
    return Item(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      edicao: edicao ?? this.edicao,
      autor: autor ?? this.autor,
      tipo: tipo ?? this.tipo,
      avaliacao: avaliacao ?? this.avaliacao,
      dataLancamento: dataLancamento ?? this.dataLancamento,
      aquisicao: aquisicao ?? this.aquisicao,
      genero: genero ?? this.genero,
      categoria: categoria ?? this.categoria,
      userlocal: userlocal ?? this.userlocal,
      data: data ?? this.data,
    );
  }

  //-- utilizado para enviar dados para o firebase com formato compatível com o JSON (map)
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'edicao': edicao,
      'autor': autor,
      'tipo': tipo,
      'avaliacao': avaliacao,
      'dataLancamento': dataLancamento,
      'aquisicao': aquisicao?.toMapAquisicaoItem(),
      'genero': genero?.toMapGeneroItem(),
      'categoria': categoria?.toMapCategoriaItem(),
      'userlocal': userlocal?.toJsonUser(),
      'data': data,
    };
  }

  //-- método que converte dados no formato JSON para o objeto Quote
  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
        id: map['id'] != null ? map['id'] as String : null,
        nome: map['nome'] != null ? map['nome'] as String : null,
        edicao: map['edicao'] != null ? map['edicao'] as String : null,
        autor: map['autor'] != null ? map['autor'] as String : null,
        tipo: map['tipo'] != null ? map['tipo'] as String : null,
        avaliacao: map['avaliacao'] != null ? map['avaliacao'] as String : null,
        dataLancamento: map['dataLancamento'] != null
            ? map['dataLancamento'] as DateTime
            : null,
        aquisicao: map['aquisicao'] != null
            ? Aquisicao.fromMap(map['aquisicao'] as Map<String, dynamic>)
            : null,
        genero: map['genero'] != null
            ? Genero.fromMap(map['genero'] as Map<String, dynamic>)
            : null,
        categoria: map['categoria'] != null
            ? Categoria.fromMap(map['categoria'] as Map<String, dynamic>)
            : null,
        userlocal: map['userlocal'] != null
            ? UserLocal.fromMap(map['userlocal'] as Map<String, dynamic>)
            : null,
        data: map['data'] != null ? map['data'] as DateTime : null);
  }

  static List<Item> fromJsonList(List list) {
    return list.map((item) => Item.fromJson(item)).toList();
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) =>
      Item.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Acervo(id: $id, nome: $nome, edicao: $edicao, autor: $autor, tipo: $tipo, avaliacao: $avaliacao, dataLancamento: $dataLancamento, aquisição: $aquisicao, genero: $genero, categoria: $categoria, userlocal: $userlocal, data: $data)';

  @override
  bool operator ==(covariant Item other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nome == nome &&
        other.edicao == edicao &&
        other.autor == autor &&
        other.tipo == tipo &&
        other.avaliacao == avaliacao &&
        other.dataLancamento == dataLancamento &&
        other.aquisicao == aquisicao &&
        other.genero == genero &&
        other.categoria == categoria &&
        other.data == data &&
        other.userlocal == userlocal;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      nome.hashCode ^
      edicao.hashCode ^
      autor.hashCode ^
      tipo.hashCode ^
      avaliacao.hashCode ^
      dataLancamento.hashCode ^
      aquisicao.hashCode ^
      genero.hashCode ^
      categoria.hashCode ^
      data.hashCode ^
      userlocal.hashCode;
}
