import 'package:byte_super_app/app/pages/configuracao/configuracao_bindings.dart';
import 'package:byte_super_app/app/pages/configuracao/configuracao_page.dart';
import 'package:get/get.dart';

class ConfiguracaoRouters {
  ConfiguracaoRouters._();

  static final routers = <GetPage>[
    GetPage(
      name: '/configuracao',
      binding: ConfiguracaoBindings(),
      page: () => ConfiguracaoPage(),
    ),
  ];
}
