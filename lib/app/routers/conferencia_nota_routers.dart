import 'package:byte_super_app/app/pages/conferencia_nota/conferencia_nota_bindings.dart';
import 'package:byte_super_app/app/pages/conferencia_nota/conferencia_nota_page.dart';
import 'package:get/get.dart';

class ConferenciaNotaRouters {
  ConferenciaNotaRouters._();

  static final routers = <GetPage>[
    GetPage(
      name: '/conferencia_nota',
      binding: ConferenciaNotaBindings(),
      page: () => const ConferenciaNotaPage(),
    )
  ];
}
