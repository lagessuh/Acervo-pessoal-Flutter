//classe para transferência de dados entre camada de visão, RN e entidades
//DTO => Data Transfer Object

//id, local de aquisição

//método construtor
class Aquisicao {
  String? id;
  String? nome;
  Aquisicao({
    this.id,
    this.nome,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
    };
  }

  Map<String, dynamic> toMapAquisicaoItem() {
    return {
      'id': id,
      'nome': nome,
    };
  }

  Aquisicao.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nome = json['nome'];

  factory Aquisicao.fromMap(Map<String, dynamic> map) {
    return Aquisicao(
      id: map['id'] != null ? map['id'] as String : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
    );
  }

  ///this method will prevent the override of toString
  String aquisicaoAsString() {
    return '#$id $nome';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(Aquisicao model) {
    return id == model.id;
  }

  @override
  String toString() => nome!;
}
