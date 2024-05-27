import 'package:get/get.dart';
import './cadastro_prod_coletor_controller.dart';

class CadastroProdColetorBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(CadastroProdColetorController(coletorDadosRepository: Get.find()));
  }
}
