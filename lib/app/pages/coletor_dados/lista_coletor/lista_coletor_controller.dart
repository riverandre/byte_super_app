import 'dart:developer';

import 'package:byte_super_app/app/core/exceptions/repository_exception.dart';
import 'package:byte_super_app/app/core/mixins/loader_mixin.dart';
import 'package:byte_super_app/app/core/mixins/messages_mixin.dart';
import 'package:byte_super_app/app/models/coletor/coletor_dados_model.dart';
import 'package:byte_super_app/app/repositories/coletor_dados/coletor_dados_repository.dart';
import 'package:get/get.dart';

class ListaColetorController extends GetxController
    with LoaderMixin, MessagesMixin {
  final ColetorDadosRepository _coletorDadosRepository;

  final _message = Rxn<MessageModel>();
  final _loading = false.obs;

  final listaColetor = <ColetorDadosModel>[].obs;

  final qtdd = 1.00.obs;

  ListaColetorController({
    required ColetorDadosRepository coletorDadosRepository,
  }) : _coletorDadosRepository = coletorDadosRepository;

  @override
  void onInit() {
    super.onInit();

    messageListener(_message);
    loaderListener(_loading);
  }

  @override
  Future<void> onReady() async {
    super.onReady();

    await getDadosColetor();
  }

  Future<void> getDadosColetor() async {
    try {
      listaColetor.clear();
      _loading.toggle();
      final prodColetor = await _coletorDadosRepository.findAllColetor();
      if (prodColetor.isNotEmpty) {
        listaColetor.addAll(prodColetor);
      }
      _loading.toggle();
    } catch (e, s) {
      log('Erro ao buscar registro', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar registro');
    }
  }

  Future<void> removeProdutoLista(ColetorDadosModel prodColetor) async {
    try {
      await _coletorDadosRepository.deleteProdListColetor(prodColetor);
      getDadosColetor();
    } catch (e, s) {
      _loading.toggle();
      log('Erro ao remover produto', error: e, stackTrace: s);
      _message(MessageModel(
        title: 'ERRO',
        message: 'Erro ao remover este produto',
        type: MessageType.error,
      ));
    }
  }

  void insereCodBarrasColetor(String codBarras) async {
    try {
      await _coletorDadosRepository.updateColetor(codBarras, qtdd.value);
      getDadosColetor();
    } catch (e, s) {
      log('Erro ao buscar registro', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar registro');
    }
  }

  Future<void> restauraDadosEnviados() async {
    try {
      _loading.toggle();
      await _coletorDadosRepository.restauraDadosEnviados();
      _loading.toggle();
      Get.offAndToNamed('/coletor_dados/menu_coletor');
    } catch (e, s) {
      log('Erro ao restaurar registro', error: e, stackTrace: s);
      _message(MessageModel(
        title: 'ERRO',
        message: 'Erro ao restaurar os registro',
        type: MessageType.error,
      ));
    }
  }

  Future<void> excluiEnviados() async {
    try {
      _loading.toggle();
      await _coletorDadosRepository.deleteColetorEnviados();
      _loading.toggle();
      Get.offAndToNamed('/coletor_dados/menu_coletor');
    } catch (e, s) {
      log('Erro ao restaurar registro', error: e, stackTrace: s);
      _message(MessageModel(
        title: 'ERRO',
        message: 'Erro ao restaurar os registro',
        type: MessageType.error,
      ));
    }
  }

  Future<void> excluiTodos() async {
    try {
      _loading.toggle();
      await _coletorDadosRepository.deleteColetor();
      _loading.toggle();
      Get.offAndToNamed('/coletor_dados/menu_coletor');
    } catch (e, s) {
      log('Erro ao restaurar registro', error: e, stackTrace: s);
      _message(MessageModel(
        title: 'ERRO',
        message: 'Erro ao restaurar os registro',
        type: MessageType.error,
      ));
    }
  }
}
