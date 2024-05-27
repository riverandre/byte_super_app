// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NotaEntradaModel {
  int id;
  String fornecedor;
  String data;
  String? status;

  NotaEntradaModel({
    required this.id,
    required this.fornecedor,
    required this.data,
    this.status = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ID': id,
      'NOME': fornecedor,
      'DATA': data,
      'CONFERENCIA': status,
    };
  }

  factory NotaEntradaModel.fromMap(Map<String, dynamic> map) {
    return NotaEntradaModel(
      id: map['ID'] ?? 0,
      fornecedor: map['NOME'] ?? '',
      data: map['DATA'] ?? '',
      status: map['CONFERENCIA'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NotaEntradaModel.fromJson(String source) =>
      NotaEntradaModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
