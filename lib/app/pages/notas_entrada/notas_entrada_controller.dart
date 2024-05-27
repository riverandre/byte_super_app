// ignore_for_file: public_member_api_docs, sort_constructors_first, invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:byte_super_app/app/core/constants/constants.dart';

class NotasEntradaController extends GetxController {
  final titleAppBar = ''.obs;
  final _codBarProd = ''.obs;
  final tabStatusPendente = true.obs;
  final tabStatusEnviado = true.obs;

  get codBarProd => _codBarProd.value;
  set setCodBarProd(String codBarra) => _codBarProd.value = codBarra;

  @override
  Future<void> onReady() async {
    super.onReady();

    final storage = GetStorage();
    titleAppBar.value = storage.read(Constants.FILIAL);
  }
}
