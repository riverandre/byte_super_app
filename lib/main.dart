import 'package:byte_super_app/app/routers/coletor_dados_routers.dart';
import 'package:byte_super_app/app/routers/conferencia_nota_routers.dart';
import 'package:byte_super_app/app/routers/configuracao_routers.dart';
import 'package:byte_super_app/app/routers/home_routers.dart';
import 'package:byte_super_app/app/routers/notas_entrada_routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/core/bindings/application_binding.dart';
import 'app/core/ui/pdv_ui.dart';
import 'app/routers/login_routers.dart';
import 'app/routers/splash_routers.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initState();

  await GetStorage.init();

  runApp(const ByteSuperApp());
}

class ByteSuperApp extends StatelessWidget {
  const ByteSuperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Byte Tools App',
      debugShowCheckedModeBanner: false,
      theme: PdvUi.theme,
      defaultTransition: Transition.fadeIn,
      initialBinding: ApplicationBinding(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      getPages: [
        ...SplashRouters.routers,
        ...LoginRouters.routers,
        ...HomeRouters.routers,
        ...ConfiguracaoRouters.routers,
        ...NotasEntradaRouters.routers,
        ...ConferenciaNotaRouters.routers,
        ...ColetorDadosRouters.routers,
      ],
    );
  }
}

@override
void initState() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
