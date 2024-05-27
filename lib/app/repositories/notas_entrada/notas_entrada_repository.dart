import 'package:byte_super_app/app/models/conferencia/nota_entrada_model.dart';

abstract class NotasEntradaRepository {
  Future<void> findNotas(String url);
  Future<List<NotaEntradaModel>> findNotasLocalPendente();
  Future<List<NotaEntradaModel>> findNotasLocalEnviado();
  Future<void> deleteStatus();
  Future<int> update(NotaEntradaModel nota);
}
