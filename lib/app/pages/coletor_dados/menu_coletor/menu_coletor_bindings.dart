import 'package:byte_super_app/app/repositories/coletor_dados/coletor_dados_repository.dart';
import 'package:byte_super_app/app/repositories/coletor_dados/coletor_dados_repository_impl.dart';
import 'package:byte_super_app/app/repositories/configuracao/configuracao_repository.dart';
import 'package:byte_super_app/app/repositories/configuracao/configuracao_repository_impl.dart';
import 'package:get/get.dart';
import './menu_coletor_controller.dart';

class MenuColetorBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ColetorDadosRepository>(() => ColetorDadosRepositoryImpl(
          sqliteConnectionFactory: Get.find(),
          dio: Get.find(),
        ));

    Get.lazyPut<ConfiguracaoRepository>(() => ConfiguracaoRepositoryImpl(
          sqliteConnectionFactory: Get.find(),
        ));

    Get.put(MenuColetorController(
      coletorDadosRepository: Get.find(),
      configuracaoRepository: Get.find(),
    ));
  }
}
