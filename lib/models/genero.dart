//classe para transferência de dados entre camada de visão, RN e entidades
//DTO => Data Transfer Object

//id, genero

//método construtor
class Genero {
  String? id;
  String? nome;
  Genero({
    this.id,
    this.nome,
  });

  Genero copyWith({
    String? id,
    String? nome,
  }) {
    return Genero(
      id: id ?? this.id,
      nome: nome ?? this.nome,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
    };
  }

  Map<String, dynamic> toMapGeneroItem() {
    return {
      'id': id,
      'nome': nome,
    };
  }

  Genero.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nome = json['nome'];

  factory Genero.fromMap(Map<String, dynamic> map) {
    return Genero(
      id: map['id'] != null ? map['id'] as String : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
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
