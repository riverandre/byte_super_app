import 'package:byte_super_app/app/pages/notas_entrada/notas_entrada_bindings.dart';
import 'package:byte_super_app/app/pages/notas_entrada/notas_entrada_page.dart';
import 'package:get/get.dart';

class NotasEntradaRouters {
  NotasEntradaRouters._();

  static final routers = <GetPage>[
    GetPage(
      name: '/notas_entrada',
      binding: NotasEntradaBindings(),
      page: () => const NotasEntradaPage(),
    ),
  ];
}
