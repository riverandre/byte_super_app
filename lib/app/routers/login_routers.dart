import 'package:get/get.dart';

import '../pages/auth/login/login_bindings.dart';
import '../pages/auth/login/login_page.dart';

class LoginRouters {
  LoginRouters._();

  static final routers = <GetPage>[
    GetPage(
      name: '/auth/login',
      binding: LoginBindings(),
      page: () => const LoginPage(),
    ),
  ];
}
