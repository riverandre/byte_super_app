import 'package:byte_super_app/app/models/conferencia/item_nota_entrada_model.dart';

abstract class ItemNotaEntradaRepository {
  Future<List<ItemNotaEntradaModel>> findRegister(int idNota);
  Future<int> insert(ItemNotaEntradaModel itemNota);
  Future<void> delete(ItemNotaEntradaModel itemNotaEntrada);
  Future<void> deleteAllItens(int idNota);

  Future<void> update(ItemNotaEntradaModel itemNotaEntrada);

  Future<String> send(List<ItemNotaEntradaModel> listaItens, String url,
      int idNota, int usuario);
}
