//classe para transferência de dados entre camada de visão, RN e entidades
//DTO => Data Transfer Object

class Categoria {
  String? id;
  String? nome;

  //id, categoria

  //método construtor
  Categoria({
    this.id,
    this.nome,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
    };
  }

  Map<String, dynamic> toMapCategoriaItem() {
    return {
      'id': id,
      'nome': nome,
    };
  }

  Map<String, dynamic> toMapCategoriaDesejos() {
    return {
      'id': id,
      'nome': nome,
    };
  }

  Categoria.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nome = json['nome'];

  factory Categoria.fromMap(Map<String, dynamic> map) {
    return Categoria(
      id: map['id'] != null ? map['id'] as String : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
    );
  }

  ///this method will prevent the override of toString
  String commodityAsString() {
    return '#$id $nome';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(Categoria model) {
    return id == model.id;
  }

  @override
  String toString() => nome!;
}
