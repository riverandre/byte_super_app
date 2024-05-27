import 'package:byte_super_app/app/repositories/configuracao/configuracao_repository.dart';
import 'package:byte_super_app/app/repositories/configuracao/configuracao_repository_impl.dart';
import 'package:get/get.dart';
import './configuracao_controller.dart';

class ConfiguracaoBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfiguracaoRepository>(
        () => ConfiguracaoRepositoryImpl(sqliteConnectionFactory: Get.find()));

    Get.put(ConfiguracaoController(configRespository: Get.find()));
  }
}
