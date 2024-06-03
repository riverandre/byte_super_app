import 'dart:developer';

import 'package:byte_super_app/app/core/exceptions/repository_exception.dart';
import 'package:byte_super_app/app/core/mixins/loader_mixin.dart';
import 'package:byte_super_app/app/core/mixins/messages_mixin.dart';
import 'package:byte_super_app/app/models/coletor/produto_coletor_model.dart';
import 'package:byte_super_app/app/core/ui/widgets/scanner_controller/barcode_scanner_window.dart';
import 'package:byte_super_app/app/repositories/coletor_dados/coletor_dados_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CadastroProdColetorController extends GetxController
    with LoaderMixin, MessagesMixin {
  final ColetorDadosRepository _coletorDadosRepository;

  CadastroProdColetorController(
      {required ColetorDadosRepository coletorDadosRepository})
      : _coletorDadosRepository = coletorDadosRepository;

  final titleAppBar = ''.obs;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();
  final qtdProduto = 1.00.obs;
  final valorQtdEC = TextEditingController();
  final codBar = ''.obs;

  @override
  void onInit() {
    super.onInit();

    loaderListener(_loading);
    messageListener(_message);
  }

  Future<String> checkCodBarras(String res) async {
    try {
      ProdutoColetorModel retorno =
          await _coletorDadosRepository.findProdColetor(res);
      if (retorno.codBarras.isNotEmpty) {
        return 'OK';
      } else {
        _message(MessageModel(
            title: 'Aviso',
            message: 'Produto não encontrado',
            type: MessageType.error));
        return 'Produto não encontrado';
      }
    } catch (e, s) {
      log('Erro ao buscar registro', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar registro');
    }
  }

  Future<void> insereCodBarrasColetor(String codBarras) async {
    try {
      double qtdProdutoColetor =
          await _coletorDadosRepository.getQtddProdLsitColetor(codBarras);

      await _coletorDadosRepository.updateColetor(
          codBarras, qtdProdutoColetor + qtdProduto.value);
      valorQtdEC.text = '';
      qtdProduto.value = 1.00;
      // Get.back();
    } catch (e, s) {
      log('Erro ao buscar registro', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar registro');
    }
  }

  Future<void> getCodBar() async {
    var res = await Get.to(() => const BarcodeScannerWithScanWindow());

    if (res != '-1') {
      if (res.isNotEmpty) {
        String check = await checkCodBarras(res);

        if (check == 'OK') {
          codBar.value = res;
        } else {
          Get.offAndToNamed('/coletor_dados/menu_coletor');
        }
      }
    } else {
      Get.offAndToNamed('/coletor_dados/menu_coletor');
    }
  }
}
