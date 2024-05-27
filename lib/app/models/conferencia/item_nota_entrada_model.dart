// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ItemNotaEntradaModel {
  int id;
  int idNota;
  String codBarras;
  double quantidade;

  ItemNotaEntradaModel({
    required this.id,
    required this.idNota,
    required this.codBarras,
    required this.quantidade,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'COD_BARRAS': codBarras,
      'ID_NOTA': idNota,
      'QTDD': quantidade,
    };
  }

  factory ItemNotaEntradaModel.fromMap(Map<String, dynamic> map) {
    return ItemNotaEntradaModel(
      id: map['id'] as int,
      idNota: map['ID_NOTA'] ?? 0,
      codBarras: map['COD_BARRAS'] ?? '',
      quantidade: map['QTDD'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemNotaEntradaModel.fromJson(String source) =>
      ItemNotaEntradaModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
