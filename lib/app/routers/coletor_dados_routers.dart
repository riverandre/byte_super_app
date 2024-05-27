import 'package:byte_super_app/app/pages/coletor_dados/cadastro_prod_coletor/cadastro_prod_coletor_bindings.dart';
import 'package:byte_super_app/app/pages/coletor_dados/cadastro_prod_coletor/cadastro_prod_coletor_page.dart';
import 'package:byte_super_app/app/pages/coletor_dados/lista_coletor/lista_coletor_bindings.dart';
import 'package:byte_super_app/app/pages/coletor_dados/lista_coletor/lista_coletor_page.dart';
import 'package:byte_super_app/app/pages/coletor_dados/menu_coletor/menu_coletor_bindings.dart';
import 'package:byte_super_app/app/pages/coletor_dados/menu_coletor/menu_coletor_page.dart';
import 'package:get/get.dart';

class ColetorDadosRouters {
  ColetorDadosRouters._();

  static final routers = <GetPage>[
    GetPage(
      name: '/coletor_dados/menu_coletor',
      binding: MenuColetorBindings(),
      page: () => const MenuColetorPage(),
    ),
    GetPage(
      name: '/coletor_dados/cadastro_prod_coletor',
      binding: CadastroProdColetorBindings(),
      page: () => const CadastroProdColetorPage(),
    ),
    GetPage(
      name: '/coletor_dados/lista_coletor',
      binding: ListaColetorBindings(),
      page: () => const ListaColetorPage(),
    ),
  ];
}
