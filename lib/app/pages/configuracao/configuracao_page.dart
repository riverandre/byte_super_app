import 'package:byte_super_app/app/core/ui/widgets/application_responsive_widget.dart';
import 'package:byte_super_app/app/core/ui/widgets/pdv_appbar.dart';
import 'package:byte_super_app/app/core/ui/widgets/pdv_button_widget.dart';
import 'package:byte_super_app/app/core/ui/widgets/pdv_textformfield.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './configuracao_controller.dart';

class ConfiguracaoPage extends GetView<ConfiguracaoController> {
  ConfiguracaoPage({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ApplicationResponsiveWidget responsiveWidget =
        ApplicationResponsiveWidget.of(context);

    return Scaffold(
      appBar: PdvAppbar(
        titulo: const Text('Doutor Byte Sistemas'),
        logOut: false,
        onPressDelete: () {
          controller.ipExternoEC.text = '';
          controller.ipInternoEC.text = '';
          controller.portaEC.text = '';
        },
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            width: responsiveWidget.width,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PdvTextformfield(
                  controller: controller.ipInternoEC,
                  label: 'Servidor (IP)',
                  enabledValue: true,
                  readyOnly: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                // PdvTextformfield(
                //   controller: controller.ipExternoEC,
                //   label: 'Servidor (IP externo)',
                //   enabledValue: true,
                //   readyOnly: false,
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                PdvTextformfield(
                  controller: controller.portaEC,
                  label: 'Porta',
                  enabledValue: true,
                  readyOnly: false,
                  inputType: TextInputType.number,
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    width: responsiveWidget.widthPercentual(50),
                    child: PdvButtonWidget(
                      label: 'Validar Conexão',
                      color: Colors.black,
                      colorText: Colors.white,
                      onPressed: () {
                        final formValid =
                            _formKey.currentState?.validate() ?? false;
                        if (formValid) {
                          if (controller.config.id != 0) {
                            controller.updateConfig();
                          } else {
                            controller.insertConfig();
                          }
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
