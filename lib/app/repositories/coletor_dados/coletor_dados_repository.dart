import 'package:byte_super_app/app/models/coletor/coletor_dados_model.dart';
import 'package:byte_super_app/app/models/coletor/produto_coletor_model.dart';

abstract class ColetorDadosRepository {
  Future<String> getAndInsertProdutos(String url);

  Future<ProdutoColetorModel> findProdColetor(String codBarras);

  Future<List<ColetorDadosModel>> findAllColetor();

  Future<void> updateColetor(String codBarras, double qtdd);

  Future<String> deleteProdColetor();

  Future<void> deleteProdListColetor(ColetorDadosModel prodColetor);

  Future<void> deleteColetor();

  Future<String> send(
      String url, List<ColetorDadosModel> listColetor, int userId);

  Future<double> getQtddProdLsitColetor(String codBarras);

  Future<void> restauraDadosEnviados();

  Future<void> deleteColetorEnviados();

  Future<String> updateColetorStatusEnviado();
}
