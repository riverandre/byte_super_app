import 'dart:developer';

import 'package:byte_super_app/app/core/exceptions/repository_exception.dart';
import 'package:byte_super_app/app/core/mixins/loader_mixin.dart';
import 'package:byte_super_app/app/core/mixins/messages_mixin.dart';
import 'package:byte_super_app/app/models/conferencia/item_nota_entrada_model.dart';
import 'package:byte_super_app/app/models/conferencia/nota_entrada_model.dart';
import 'package:byte_super_app/app/repositories/configuracao/configuracao_repository.dart';
import 'package:byte_super_app/app/repositories/item_nota_entrada/item_nota_entrada_repository.dart';
import 'package:byte_super_app/app/repositories/notas_entrada/notas_entrada_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotasEntradaPendenteController extends GetxController
    with LoaderMixin, MessagesMixin {
  final NotasEntradaRepository _notasEntradaRepository;
  final ConfiguracaoRepository _configRepository;
  final ItemNotaEntradaRepository _itemNotaEntradaRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  final listaNotas = <NotaEntradaModel>[].obs;
  final listaPesq = <NotaEntradaModel>[].obs;
  final quantidade = 1.00.obs;
  final filtroData = false.obs;

  final heightDefault = 0.83.obs;
  final visible = false.obs;

  final dataInicioFiltro = ''.obs;
  final dataFimFiltro = ''.obs;

  final inputDataInicioEC = TextEditingController(text: '');
  final inputDataFimEC = TextEditingController(text: '');

  NotasEntradaPendenteController({
    required NotasEntradaRepository notasEntradaRepository,
    required ConfiguracaoRepository configRepository,
    required ItemNotaEntradaRepository itemNotaEntradaRepository,
  })  : _notasEntradaRepository = notasEntradaRepository,
        _configRepository = configRepository,
        _itemNotaEntradaRepository = itemNotaEntradaRepository;
  final _codBarProd = ''.obs;

  get codBarProd => _codBarProd.value;
  set setCodBarProd(String codBarra) => _codBarProd.value = codBarra;

  @override
  void onInit() {
    super.onInit();

    loaderListener(_loading);
    messageListener(_message);
  }

  @override
  Future<void> onReady() async {
    super.onReady();

    await _getNotas();
  }

  Future<void> _getNotas() async {
    try {
      _loading.toggle();
      listaNotas.clear();
      final config = await _configRepository.findFirst();
      String url = config.ipInterno != ''
          ? 'http://${config.ipInterno}:${config.porta}'
          : 'http://${config.ipExterno}:${config.porta}';
      String value = await _configRepository.testConnection(url);
      if (value == 'OK') {
        await _notasEntradaRepository.deleteStatus();
        await _notasEntradaRepository.findNotas(url);
        final notasLocal =
            await _notasEntradaRepository.findNotasLocalPendente();
        if (notasLocal.isNotEmpty) {
          _loading.toggle();
          listaNotas.addAll(notasLocal);
        } else {
          _loading.toggle();
          listaNotas.value = [];
          _message(MessageModel(
              title: 'Aviso',
              message: 'Nenhuma nota disponível',
              type: MessageType.info));
        }
      } else {
        _message(MessageModel(
            title: 'Erro',
            message: 'Servidor não encontrado ou fora do ar.',
            type: MessageType.error));
      }
    } catch (e, s) {
      _loading.toggle();
      log('Erro ao buscar notas', error: e, stackTrace: s);
      _message(MessageModel(
          title: 'Erro',
          message: 'Erro ao buscar lista de notas',
          type: MessageType.error));
    }
  }

  Future<List<ItemNotaEntradaModel>> verificaItensNota(int idNota) async {
    try {
      final result = await _itemNotaEntradaRepository.findRegister(idNota);
      return result;
    } catch (e, s) {
      log('Erro ao buscar registro', error: e, stackTrace: s);

      throw RepositoryException(message: 'Erro ao buscar registro');
    }
  }

  Future<void> insertProduto(
      ItemNotaEntradaModel itemNota, NotaEntradaModel fornecedor) async {
    try {
      _loading.toggle();
      await _itemNotaEntradaRepository.insert(itemNota);
      _loading.toggle();
      Get.toNamed('/conferencia_nota', arguments: fornecedor);
    } catch (e, s) {
      _loading.toggle();
      log('Erro ao inserir registro', error: e, stackTrace: s);
      _message(MessageModel(
        title: 'ERRO',
        message: 'Erro ao cadastrar',
        type: MessageType.error,
      ));
    }
  }

  void filterDateList() {
    try {
      dataInicioFiltro.value = inputDataInicioEC.text;
      dataFimFiltro.value = inputDataFimEC.text;
      listaPesq.value = listaNotas;
      final listaTemp = listaPesq;
      var dateInicio = DateFormat('dd/MM/yyyy').parse(dataInicioFiltro.value);
      var dateFinal = DateFormat('dd/MM/yyyy').parse(dataFimFiltro.value);
      List<NotaEntradaModel> notas = [];
      for (var element in listaTemp) {
        final dateTime = element.data.split('-');

        var data = DateFormat('dd/MM/yyyy')
            .parse('${dateTime[2]}/${dateTime[1]}/${dateTime[0]}');
        if ((data.isAfter(dateInicio) || data.isAtSameMomentAs(dateInicio)) &&
            (data.isBefore(dateFinal) || data.isAtSameMomentAs(dateFinal))) {
          notas.add(element);
        }
      }
      notas.sort(
        (a, b) => a.data.compareTo(b.data),
      );
      listaNotas.clear();
      listaNotas.addAll(notas);
      filtroData.value = true;
      Get.back();
    } catch (e, s) {
      log('Erro ao filtrar registro', error: e, stackTrace: s);
    }
  }

  void clearFilterData() {
    inputDataInicioEC.text = '';
    inputDataFimEC.text = '';
    dataInicioFiltro.value = '';
    dataFimFiltro.value = '';
    heightDefault.value = 0.83;
    visible.value = false;
    _getNotas();
  }

  void messagePreencherDadas() {
    _message(MessageModel(
      title: 'Aviso',
      message: 'Preencher data inicial e final para filtro',
      type: MessageType.info,
    ));
  }
}
