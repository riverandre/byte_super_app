import 'package:get/get.dart';
import './notas_entrada_controller.dart';

class NotasEntradaBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(NotasEntradaController());
  }
}
