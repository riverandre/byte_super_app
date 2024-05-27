import 'package:get/get.dart';

import '../pages/home/home_bindings.dart';
import '../pages/home/home_page.dart';

class HomeRouters {
  HomeRouters._();

  static final routers = <GetPage>[
    GetPage(
      name: '/home',
      binding: HomeBindings(),
      page: () => const HomePage(),
    )
  ];
}
