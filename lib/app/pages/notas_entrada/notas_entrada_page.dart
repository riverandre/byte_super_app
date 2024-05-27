// ignore_for_file: invalid_use_of_protected_member

import 'package:byte_super_app/app/core/ui/widgets/pdv_appbar.dart';
import 'package:byte_super_app/app/pages/notas_entrada/enviados/notas_entrada_enviado_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './notas_entrada_controller.dart';
import 'pendente/notas_entrada_pendente_page.dart';
import 'widgets/head_tabs.dart';

class NotasEntradaPage extends GetView<NotasEntradaController> {
  const NotasEntradaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PdvAppbar(
        titulo: Obx(() {
          return Text(
            controller.titleAppBar.value,
          );
        }),
        remove: true,
      ),
      body: SafeArea(
        child: Center(
          child: Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  HeadTabs(
                      tabUsedPendente: controller.tabStatusPendente.value,
                      tabUsedEnviado: controller.tabStatusPendente.value,
                      toggleTabPendente: () {
                        controller.tabStatusPendente.value = true;
                        controller.tabStatusEnviado.value = false;
                      },
                      toggleTabEnviado: () {
                        controller.tabStatusPendente.value = false;
                        controller.tabStatusEnviado.value = true;
                      }),
                  controller.tabStatusPendente.value
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.83,
                          child: const NotasEntradaPendentePage(),
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height * 0.83,
                          child: const NotasEntradaEnviadoPage(),
                        ),
                ],
              )),
        ),
      ),
    );
  }
}
