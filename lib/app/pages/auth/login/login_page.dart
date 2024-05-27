import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/ui/pdv_state.dart';
import '../../../core/ui/widgets/application_responsive_widget.dart';
import '../../../core/ui/widgets/pdv_button_widget.dart';
import '../../../core/ui/widgets/pdv_textformfield.dart';
import './login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends PdvState<LoginPage, LoginController> {
  final _formKey = GlobalKey<FormState>();
  // final _usuario = TextEditingController();
  // final _senha = TextEditingController();
  final _usuario = TextEditingController(text: '10');
  final _senha = TextEditingController(text: '091170');

  @override
  void dispose() {
    super.dispose();

    _usuario.dispose();
    _senha.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ApplicationResponsiveWidget responsiveWidget =
        ApplicationResponsiveWidget.of(context);

    const version = 'v1.1.0';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: SizedBox(
              width: responsiveWidget.width,
              height: responsiveWidget.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(55, 50, 55, 0),
                    child: SizedBox(
                      height: responsiveWidget.heightPercentual(30),
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(55, 0, 55, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: responsiveWidget.widthPercentual(45),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PdvTextformfield(
                                controller: _usuario,
                                readyOnly: false,
                                enabledValue: true,
                                inputType: TextInputType.number,
                                label: 'Usuário',
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              PdvTextformfield(
                                controller: _senha,
                                readyOnly: false,
                                enabledValue: true,
                                label: 'Senha',
                                obscureText: true,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  PdvButtonWidget(
                                    width: responsiveWidget.widthPercentual(35),
                                    height: 50,
                                    color: Colors.grey[200],
                                    onPressed: () {
                                      final formValid =
                                          _formKey.currentState?.validate() ??
                                              false;
                                      if (formValid) {
                                        controller.login(
                                          usuario: _usuario.text,
                                          password: _senha.text,
                                        );
                                      }
                                    },
                                    label: 'ENTRAR',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: responsiveWidget.width,
                    height: responsiveWidget.heightPercentual(10),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'ByteVersion $version',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w300),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.toNamed('/configuracao');
                          },
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
