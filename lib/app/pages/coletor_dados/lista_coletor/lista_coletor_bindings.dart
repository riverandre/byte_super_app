import 'package:get/get.dart';
import './lista_coletor_controller.dart';

class ListaColetorBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ListaColetorController(coletorDadosRepository: Get.find()));
  }
}
