import 'package:byte_super_app/app/core/ui/widgets/pdv_appbar.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../core/ui/widgets/application_responsive_widget.dart';
import './home_controller.dart';
import 'widgets/dashboard_tile_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ApplicationResponsiveWidget responsive =
        ApplicationResponsiveWidget(context);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        // logic
      },
      child: Scaffold(
        appBar: PdvAppbar(
          titulo: Obx(() {
            return Text(
              controller.titleAppBar.value,
              style: const TextStyle(
                color: Colors.white,
              ),
            );
          }),
          logOut: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Column(
            children: [
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          DashBoardTileWIdget(
                            width: responsive.widthPercentual(35),
                            label: 'Conferência',
                            labelSize: 18,
                            color: Colors.green[700]!,
                            icon: FontAwesomeIcons.fileLines,
                            iconSize: responsive.diagonalPercentual(8),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            onTap: () {
                              Get.toNamed('/notas_entrada');
                            },
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          DashBoardTileWIdget(
                            width: responsive.widthPercentual(35),
                            label: 'Coletor de dados',
                            labelSize: 18,
                            color: Colors.green[700]!,
                            icon: FontAwesomeIcons.boxOpen,
                            iconSize: responsive.diagonalPercentual(8),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            onTap: () async {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (_) {
                                    return Dialog(
                                      child: Container(
                                        width: 200,
                                        height: 250,
                                        decoration: ShapeDecoration(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(34),
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Column(
                                            children: [
                                              const Text('Sincronizando...',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24,
                                                  )),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Lottie.asset(
                                                'assets/images/file-syncing-migrating-animation.json',
                                                width: 200,
                                                height: 200,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                              String value =
                                  await controller.sincronizaProdutos();
                              if (value == 'OK') {
                                Get.back();
                                Get.toNamed('/coletor_dados/menu_coletor');
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
