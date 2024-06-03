// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:byte_super_app/app/core/ui/widgets/application_responsive_widget.dart';
import 'package:byte_super_app/app/core/ui/widgets/pdv_appbar.dart';
import 'package:byte_super_app/app/pages/home/widgets/dashboard_tile_widget.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './menu_coletor_controller.dart';

class MenuColetorPage extends GetView<MenuColetorController> {
  const MenuColetorPage({super.key});

  @override
  Widget build(BuildContext context) {
    ApplicationResponsiveWidget responsive =
        ApplicationResponsiveWidget(context);

    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed('/home');
        return true;
      },
      child: Scaffold(
        appBar: PdvAppbar(
          titulo: const Text(
            'Coletor de dados',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          remove: true,
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              DashBoardTileWIdget(
                width: responsive.widthPercentual(35),
                label: 'Conferência',
                labelSize: 18,
                color: Colors.green[800]!,
                icon: Icons.barcode_reader,
                iconSize: responsive.diagonalPercentual(7),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                onTap: () {
                  Get.toNamed('/coletor_dados/cadastro_prod_coletor');
                },
              ),
              const SizedBox(
                height: 20,
              ),
              DashBoardTileWIdget(
                width: responsive.widthPercentual(35),
                label: 'Visualizar lista',
                labelSize: 18,
                color: Colors.green[800]!,
                icon: Icons.list_alt,
                iconSize: responsive.diagonalPercentual(7),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                onTap: () {
                  Get.toNamed('/coletor_dados/lista_coletor');
                },
              ),
              const SizedBox(
                height: 20,
              ),
              DashBoardTileWIdget(
                width: responsive.widthPercentual(35),
                label: 'Transmitir dados',
                labelSize: 18,
                color: Colors.green[800]!,
                icon: Icons.send_to_mobile,
                iconSize: responsive.diagonalPercentual(7),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                onTap: () async {
                  String result = await controller.enviaColetor();
                  if (result == 'OK') {
                    AwesomeDialog(
                      context: context,
                      animType: AnimType.leftSlide,
                      headerAnimationLoop: false,
                      dialogType: DialogType.success,
                      showCloseIcon: true,
                      title: 'Aviso',
                      desc: 'Dados enviados com sucesso!',
                    ).show();

                    await Future.delayed(const Duration(seconds: 2)).then(
                      (value) {
                        Get.offAndToNamed('/home');
                      },
                    );
                  } else {
                    AwesomeDialog(
                      context: context,
                      animType: AnimType.leftSlide,
                      headerAnimationLoop: false,
                      dialogType: DialogType.info,
                      showCloseIcon: true,
                      title: 'Aviso',
                      desc: 'Nenhum registro para enviar!',
                    ).show();

                    await Future.delayed(const Duration(seconds: 2)).then(
                      (value) {
                        Get.back();
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
