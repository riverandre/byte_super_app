// ignore_for_file: deprecated_member_use

import 'package:byte_super_app/app/core/ui/pdv_state_coletor.dart';
import 'package:byte_super_app/app/core/ui/widgets/application_responsive_widget.dart';
import 'package:byte_super_app/app/core/ui/widgets/pdv_appbar.dart';
import 'package:byte_super_app/app/core/ui/widgets/plus_minus_box.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import './cadastro_prod_coletor_controller.dart';

class CadastroProdColetorPage extends StatefulWidget {
  const CadastroProdColetorPage({super.key});

  @override
  State<CadastroProdColetorPage> createState() =>
      _CadastroProdColetorPageState();
}

class _CadastroProdColetorPageState extends PdvStateColetor<
    CadastroProdColetorPage, CadastroProdColetorController> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getCodBar();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ApplicationResponsiveWidget responsiveWidget =
        ApplicationResponsiveWidget.of(context);
    return Scaffold(
      appBar: PdvAppbar(
        titulo: const Text(
          'Coletor de Dados',
        ),
        remove: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Obx(() => Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Visibility(
                        visible: controller.codBar.value.isEmpty,
                        child: Column(
                          children: [
                            const Text('Buscando produto na base de dados'),
                            const SizedBox(
                              height: 10,
                            ),
                            LoadingAnimationWidget.inkDrop(
                              color: Colors.blueAccent,
                              size: 50,
                            ),
                          ],
                        )),
                  )),
              Obx(() {
                return Visibility(
                  visible: controller.codBar.value.isNotEmpty,
                  child: Column(
                    children: [
                      Container(
                          width: responsiveWidget.width,
                          height: responsiveWidget.heightPercentual(80),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(34),
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Text(
                                  'Produto: ${controller.codBar}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: responsiveWidget.widthPercentual(80),
                                height: 100,
                                color: Colors.white,
                                child: PlusMinusBox(
                                  quantity: controller.qtdProduto.value,
                                  plusBallBack: () =>
                                      controller.qtdProduto.value++,
                                  minusCallBack: () =>
                                      controller.qtdProduto.value > 1
                                          ? controller.qtdProduto.value--
                                          : controller.qtdProduto.value,
                                  editQuantidadeCallBack: () => showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        child: Container(
                                          height: 200,
                                          width: 100,
                                          decoration: ShapeDecoration(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(34),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Column(
                                              children: [
                                                const Text(
                                                    'Informe a quantidade desejada',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    autofocus: true,
                                                    controller:
                                                        controller.valorQtdEC,
                                                    textAlign: TextAlign.center,
                                                    keyboardType:
                                                        TextInputType.phone,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    final valor = controller
                                                        .valorQtdEC.text;
                                                    if (valor.isNotEmpty &&
                                                        valor != '0') {
                                                      controller.qtdProduto
                                                              .value =
                                                          double.parse(valor);

                                                      Get.back();
                                                    }
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape:
                                                        const StadiumBorder(),
                                                    backgroundColor:
                                                        Colors.green,
                                                  ),
                                                  child: const Text(
                                                    'Salvar',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 100,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10.0, left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      width: 120,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          controller.qtdProduto.value = 1.00;

                                          Get.offAndToNamed(
                                              '/coletor_dados/menu_coletor');
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  Colors.red[100]),
                                        ),
                                        child: const Text(
                                          'Cancelar',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFFFF0000),
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      width: 120,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          //FAZER O INSERT NA TABELA DO COLETOR COM O CODIGO DE BARRAS
                                          await controller
                                              .insereCodBarrasColetor(
                                                  controller.codBar.value);

                                          Future.delayed(const Duration(
                                                  milliseconds: 150))
                                              .then((value) async {
                                            await controller.getCodBar();
                                          });
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    const Color(0xA5D0FFC4))),
                                        child: const Text(
                                          'Confirmar',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFF18C754),
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
