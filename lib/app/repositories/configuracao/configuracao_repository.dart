import 'package:byte_super_app/app/models/configuracao/configuracao_model.dart';

abstract class ConfiguracaoRepository {
  Future<int> insert(ConfiguracaoModel configuracao);
  Future<void> update(ConfiguracaoModel configuracao);
  Future<ConfiguracaoModel> findFirst();
  Future<String> testConnection(String url);
}
