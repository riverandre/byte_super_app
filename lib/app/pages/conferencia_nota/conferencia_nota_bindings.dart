import 'package:byte_super_app/app/repositories/configuracao/configuracao_repository.dart';
import 'package:byte_super_app/app/repositories/configuracao/configuracao_repository_impl.dart';
import 'package:byte_super_app/app/repositories/item_nota_entrada/item_nota_entrada_repository.dart';
import 'package:byte_super_app/app/repositories/item_nota_entrada/item_nota_entrada_repository_impl.dart';
import 'package:byte_super_app/app/repositories/notas_entrada/notas_entrada_repository.dart';
import 'package:byte_super_app/app/repositories/notas_entrada/notas_entrada_repository_impl.dart';
import 'package:get/get.dart';
import './conferencia_nota_controller.dart';

class ConferenciaNotaBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotasEntradaRepository>(() => NotasEntradaRepositoryImpl(
          dio: Get.find(),
          sqliteConnectionFactory: Get.find(),
        ));

    Get.lazyPut<ItemNotaEntradaRepository>(() => ItemNotaEntradaRepositoryImpl(
          sqliteConnectionFactory: Get.find(),
          dio: Get.find(),
        ));

    Get.lazyPut<ConfiguracaoRepository>(() => ConfiguracaoRepositoryImpl(
          sqliteConnectionFactory: Get.find(),
        ));

    Get.put(ConferenciaNotaController(
      notasEntradaRepository: Get.find(),
      itemNotaEntradaRepository: Get.find(),
      configuracaoRepository: Get.find(),
    ));
  }
}
