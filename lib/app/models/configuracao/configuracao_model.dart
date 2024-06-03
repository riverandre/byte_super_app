import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ConfiguracaoModel {
  int id;
  String ipInterno;
  String? ipExterno;
  int porta;

  ConfiguracaoModel({
    required this.id,
    required this.ipInterno,
    this.ipExterno,
    required this.porta,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'IP_INTERNO': ipInterno,
      'IP_EXTERNO': ipExterno,
      'PORTA': porta,
    };
  }

  factory ConfiguracaoModel.fromMap(Map<String, dynamic> map) {
    return ConfiguracaoModel(
      id: map['id'] ?? 0,
      ipInterno: map['IP_INTERNO'] ?? '',
      ipExterno: map['IP_EXTERNO'] ?? '',
      porta: map['PORTA'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConfiguracaoModel.fromJson(String source) =>
      ConfiguracaoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ConfiguracaoModel(id: $id, ipInterno: $ipInterno, ipExterno: $ipExterno, porta: $porta)';
  }
}
