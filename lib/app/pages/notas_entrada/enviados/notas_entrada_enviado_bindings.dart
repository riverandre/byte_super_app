import 'package:byte_super_app/app/pages/notas_entrada/enviados/notas_entrada_enviado_controller.dart';
import 'package:byte_super_app/app/repositories/item_nota_entrada/item_nota_entrada_repository.dart';
import 'package:byte_super_app/app/repositories/item_nota_entrada/item_nota_entrada_repository_impl.dart';
import 'package:byte_super_app/app/repositories/notas_entrada/notas_entrada_repository.dart';
import 'package:byte_super_app/app/repositories/notas_entrada/notas_entrada_repository_impl.dart';
import 'package:get/get.dart';

class NotasEntradaEnviadoBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotasEntradaRepository>(
      () => NotasEntradaRepositoryImpl(
        dio: Get.find(),
        sqliteConnectionFactory: Get.find(),
      ),
    );

    Get.lazyPut<ItemNotaEntradaRepository>(
      () => ItemNotaEntradaRepositoryImpl(
        dio: Get.find(),
        sqliteConnectionFactory: Get.find(),
      ),
    );

    Get.put(NotasEntradaEnviadoController(
      notasEntradaRepository: Get.find(),
      itemNotaEntradaRepository: Get.find(),
    ));
  }
}
