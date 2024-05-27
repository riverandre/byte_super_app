import 'dart:developer';

import 'package:byte_super_app/app/core/constants/constants.dart';
import 'package:byte_super_app/app/core/mixins/messages_mixin.dart';
import 'package:byte_super_app/app/repositories/coletor_dados/coletor_dados_repository.dart';
import 'package:byte_super_app/app/repositories/configuracao/configuracao_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController with MessagesMixin {
  final ConfiguracaoRepository _configRepository;
  final ColetorDadosRepository _coletorDadosRepository;
  final _message = Rxn<MessageModel>();

  final titleAppBar = ''.obs;

  HomeController({
    required ConfiguracaoRepository configuracaoRepository,
    required ColetorDadosRepository coletorDadosRepository,
  })  : _configRepository = configuracaoRepository,
        _coletorDadosRepository = coletorDadosRepository;

  @override
  void onReady() {
    super.onReady();

    final storage = GetStorage();
    titleAppBar.value = storage.read(Constants.FILIAL);
  }

  Future<void> sincronizaProdutos() async {
    try {
      final config = await _configRepository.findFirst();
      String url = config.ipInterno != ''
          ? 'http://${config.ipInterno}:${config.porta}'
          : 'http://${config.ipExterno}:${config.porta}';
      String value = await _configRepository.testConnection(url);
      if (value == 'OK') {
        await _coletorDadosRepository.deleteProdColetor();
        await _coletorDadosRepository.getAndInsertProdutos(url);
      } else {
        _message(MessageModel(
            title: 'Erro',
            message: 'Servidor não encontrado ou fora do ar.',
            type: MessageType.error));
      }
    } catch (e, s) {
      log('Erro ao buscar produtos', error: e, stackTrace: s);
      _message(MessageModel(
          title: 'Erro',
          message: 'Erro ao buscar lista de produtos',
          type: MessageType.error));
    }
  }
}
