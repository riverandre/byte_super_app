// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:byte_super_app/app/repositories/configuracao/configuracao_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/constants/constants.dart';
import '../../../core/exceptions/user_notfound_exception.dart';
import '../../../core/mixins/loader_mixin.dart';
import '../../../core/mixins/messages_mixin.dart';
import '../../../repositories/auth/auth_repository.dart';

class LoginController extends GetxController with LoaderMixin, MessagesMixin {
  final AuthRepository _authRepository;
  final ConfiguracaoRepository _configRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  LoginController({
    required AuthRepository authRepository,
    required ConfiguracaoRepository configRepository,
  })  : _authRepository = authRepository,
        _configRepository = configRepository;

  @override
  void onInit() {
    super.onInit();
    loaderListener(_loading);
    messageListener(_message);
  }

  Future<void> login(
      {required String usuario, required String password}) async {
    try {
      _loading.toggle();

      final config = await _configRepository.findFirst();
      if (config.id == 0) {
        _loading.toggle();
        _message(MessageModel(
          title: 'Aviso',
          message: 'Informar os dados da conexão',
          type: MessageType.info,
        ));
      } else {
        String url = config.ipInterno != ''
            ? 'http://${config.ipInterno}:${config.porta}'
            : 'http://${config.ipExterno}:${config.porta}';
        String value = await _configRepository.testConnection(url);
        if (value == 'OK') {
          final userLegged =
              await _authRepository.login(usuario, password, url);

          final valueAuth = userLegged.split('&&');

          final filial = valueAuth[0];
          final user = valueAuth[1];

          final storage = GetStorage();
          storage.write(Constants.USER_NAME, user);
          storage.write(Constants.FILIAL, filial);
          storage.write(Constants.USER_ID, usuario);
          _loading.toggle();
          Get.offAllNamed('/home');
        }
      }
    } on UserNotFoundException catch (e, s) {
      _loading.toggle();
      log('Login ou senha invalidos', error: e, stackTrace: s);
      _message(MessageModel(
        title: 'Erro',
        message: 'Login ou senha inválidos',
        type: MessageType.error,
      ));
    } catch (e, s) {
      _loading.toggle();
      log('Login ou senha invalidos', error: e, stackTrace: s);
      _message(MessageModel(
        title: 'Erro',
        message: 'Servidor não encontrado ou fora do ar.',
        type: MessageType.error,
      ));
    }
  }
}
