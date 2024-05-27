import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ColetorDadosModel {
  int id;
  String codBarras;
  double qtdd;
  String sincronizado;

  ColetorDadosModel({
    required this.id,
    required this.codBarras,
    required this.qtdd,
    this.sincronizado = 'N',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'COD_BARRAS': codBarras,
      'QTDD': qtdd,
      'SINCRONIZADO': sincronizado,
    };
  }

  factory ColetorDadosModel.fromMap(Map<String, dynamic> map) {
    return ColetorDadosModel(
      id: map['id'] as int,
      codBarras: map['COD_BARRAS'] as String,
      qtdd: map['QTDD'] as double,
      sincronizado: map['SINCRONIZADO'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ColetorDadosModel.fromJson(String source) =>
      ColetorDadosModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
