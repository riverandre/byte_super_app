import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProdutoColetorModel {
  int id;
  String codBarras;

  ProdutoColetorModel({
    required this.id,
    required this.codBarras,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'COD_BARRAS': codBarras,
    };
  }

  factory ProdutoColetorModel.fromMap(Map<String, dynamic> map) {
    return ProdutoColetorModel(
      id: map['id'] ?? 0,
      codBarras: map['COD_BARRAS'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProdutoColetorModel.fromJson(String source) =>
      ProdutoColetorModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
