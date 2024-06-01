import 'dart:developer';

import 'package:byte_super_app/app/core/constants/constants.dart';
import 'package:byte_super_app/app/core/exceptions/repository_exception.dart';
import 'package:byte_super_app/app/core/mixins/loader_mixin.dart';
import 'package:byte_super_app/app/core/mixins/messages_mixin.dart';
import 'package:byte_super_app/app/repositories/coletor_dados/coletor_dados_repository.dart';
import 'package:byte_super_app/app/repositories/configuracao/configuracao_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MenuColetorController extends GetxController
    with LoaderMixin, MessagesMixin {
  final ColetorDadosRepository _coletorDadosRepository;
  final ConfiguracaoRepository _configRepository;

  final titleAppBar = ''.obs;
  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  MenuColetorController({
    required ColetorDadosRepository coletorDadosRepository,
    required ConfiguracaoRepository configuracaoRepository,
  })  : _coletorDadosRepository = coletorDadosRepository,
        _configRepository = configuracaoRepository;

  @override
  void onInit() {
    loaderListener(_loading);
    messageListener(_message);
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();

    final storage = GetStorage();
    titleAppBar.value = storage.read(Constants.FILIAL);
  }

  Future<String> enviaColetor() async {
    try {
      _loading.toggle();

      final config = await _configRepository.findFirst();
      String url = config.ipInterno != ''
          ? 'http://${config.ipInterno}:${config.porta}'
          : 'http://${config.ipExterno}:${config.porta}';
      String value = await _configRepository.testConnection(url);
      if (value == 'OK') {
        int userId = int.parse(GetStorage().read(Constants.USER_ID));
        final coletorDados = await _coletorDadosRepository.findAllColetor();
        if (coletorDados.isNotEmpty) {
          final String retorno =
              await _coletorDadosRepository.send(url, coletorDados, userId);
          if (retorno == 'OK') {
            await _coletorDadosRepository.updateColetorStatusEnviado();
            _loading.toggle();
          }
        } else {
          value = 'SEM REGISTRO';
        }
      }
      return value;
    } catch (e, s) {
      _loading.toggle();
      log('Erro ao enviar dados do coletor', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar registro');

      // _message(MessageModel(
      //   title: 'ERRO',
      //   message: 'Erro ao dados do coletor',
      //   type: MessageType.error,
      // ));
    }
  }
}
