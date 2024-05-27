import 'package:byte_super_app/app/repositories/configuracao/configuracao_repository.dart';
import 'package:byte_super_app/app/repositories/configuracao/configuracao_repository_impl.dart';
import 'package:get/get.dart';

import '../../../repositories/auth/auth_repository.dart';
import '../../../repositories/auth/auth_repository_impl.dart';
import './login_controller.dart';

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl());

    Get.lazyPut<ConfiguracaoRepository>(() => ConfiguracaoRepositoryImpl(
          sqliteConnectionFactory: Get.find(),
        ));

    Get.put(LoginController(
        authRepository: Get.find(), configRepository: Get.find()));
  }
}
