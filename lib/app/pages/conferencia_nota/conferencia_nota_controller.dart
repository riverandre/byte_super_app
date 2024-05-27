// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';

import 'package:byte_super_app/app/core/constants/constants.dart';
import 'package:byte_super_app/app/core/exceptions/repository_exception.dart';
import 'package:byte_super_app/app/core/mixins/loader_mixin.dart';
import 'package:byte_super_app/app/core/mixins/messages_mixin.dart';
import 'package:byte_super_app/app/models/conferencia/item_nota_entrada_model.dart';
import 'package:byte_super_app/app/models/conferencia/nota_entrada_model.dart';
import 'package:byte_super_app/app/repositories/configuracao/configuracao_repository.dart';
import 'package:byte_super_app/app/repositories/item_nota_entrada/item_nota_entrada_repository.dart';
import 'package:byte_super_app/app/repositories/notas_entrada/notas_entrada_repository.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ConferenciaNotaController extends GetxController
    with LoaderMixin, MessagesMixin {
  final _loading = false.obs;
  final _message = Rxn<MessageModel>();
  final ItemNotaEntradaRepository _itemNotaEntradaRepository;
  final NotasEntradaRepository _notaEntradaRepository;
  final ConfiguracaoRepository _configRepository;

  final titleAppBar = ''.obs;
  final listaItens = <ItemNotaEntradaModel>[].obs;
  var notaEntrada = Get.arguments as NotaEntradaModel;
  var itemNota =
      ItemNotaEntradaModel(id: 0, idNota: 0, codBarras: '', quantidade: 1);
  final qtdProduto = 1.00.obs;
  bool prodCadastrado = false;
  final notaEnviada = false.obs;

  ConferenciaNotaController({
    required ItemNotaEntradaRepository itemNotaEntradaRepository,
    required ConfiguracaoRepository configuracaoRepository,
    required NotasEntradaRepository notasEntradaRepository,
  })  : _itemNotaEntradaRepository = itemNotaEntradaRepository,
        _configRepository = configuracaoRepository,
        _notaEntradaRepository = notasEntradaRepository;

  @override
  void onInit() {
    super.onInit();

    loaderListener(_loading);
    messageListener(_message);
  }

  @override
  void onReady() async {
    super.onReady();
    final storage = GetStorage();
    titleAppBar.value = storage.read(Constants.FILIAL);

    await _getItensNota();

    if (notaEntrada.status == 'S') {
      notaEnviada.value = true;
    }
  }

  Future<void> _getItensNota() async {
    try {
      _loading.toggle();
      listaItens.clear();
      final result =
          await _itemNotaEntradaRepository.findRegister(notaEntrada.id);
      listaItens.addAll(result);
      _loading.toggle();
    } catch (e, s) {
      log('Erro ao buscar registro', error: e, stackTrace: s);

      throw RepositoryException(message: 'Erro ao buscar registro');
    }
  }

  Future<void> verificaProduto(res) async {
    prodCadastrado = false;

    for (var element in listaItens) {
      if (element.codBarras == res) {
        qtdProduto.value = 1;
        prodCadastrado = true;
        itemNota.id = element.id;
        itemNota.idNota = element.idNota;
        itemNota.codBarras = element.codBarras;
        itemNota.quantidade = element.quantidade;
      }
    }
  }

  Future<void> insertProduto(ItemNotaEntradaModel itemNotaEntradaModel) async {
    try {
      await _itemNotaEntradaRepository.insert(itemNotaEntradaModel);
      _getItensNota();
    } catch (e, s) {
      _loading.toggle();
      log('Erro ao inserir registro', error: e, stackTrace: s);
      _message(MessageModel(
        title: 'ERRO',
        message: 'Erro ao cadastrar produto',
        type: MessageType.error,
      ));
    }
  }

  Future<void> alteraProduto(ItemNotaEntradaModel itemNotaEntrada) async {
    try {
      await _itemNotaEntradaRepository.update(itemNotaEntrada);
      await _getItensNota();
    } catch (e, s) {
      _loading.toggle();
      log('Erro ao atualizar produto', error: e, stackTrace: s);
      _message(MessageModel(
        title: 'ERRO',
        message: 'Erro ao atualizar',
        type: MessageType.error,
      ));
    }
  }

  Future<void> removeProdutoLista(ItemNotaEntradaModel itemNotaEntrada) async {
    try {
      await _itemNotaEntradaRepository.delete(itemNotaEntrada);
      _getItensNota();
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

  Future<void> sendNota() async {
    try {
      _loading.toggle();

      final config = await _configRepository.findFirst();
      String url = config.ipInterno != ''
          ? 'http://${config.ipInterno}:${config.porta}'
          : 'http://${config.ipExterno}:${config.porta}';
      String value = await _configRepository.testConnection(url);
      if (value == 'OK') {
        int userId = int.parse(GetStorage().read(Constants.USER_ID));

        String value = await _itemNotaEntradaRepository.send(
            listaItens.value, url, notaEntrada.id, userId);
        if (value == 'OK') {
          // STATUS-> S (APAGAR), P (NAO FAZ NADA), N (PENDENTE)
          notaEntrada.status = 'S';
          await _notaEntradaRepository.update(notaEntrada);
        }
        _loading.toggle();
        Get.offNamedUntil('/home', (route) => false);
      }
    } catch (e, s) {
      _loading.toggle();
      log('Erro ao enviar dados da nota', error: e, stackTrace: s);
      _message(MessageModel(
        title: 'ERRO',
        message: 'Erro ao dados da nota',
        type: MessageType.error,
      ));
    }
  }
}
