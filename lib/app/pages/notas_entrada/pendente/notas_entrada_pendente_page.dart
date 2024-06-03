import 'package:byte_super_app/app/core/ui/pdv_state.dart';
import 'package:byte_super_app/app/models/conferencia/item_nota_entrada_model.dart';
import 'package:byte_super_app/app/core/ui/widgets/scanner_controller/barcode_scanner_window.dart';
import 'package:byte_super_app/app/pages/notas_entrada/pendente/notas_entrada_pendente_bindings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../widgets/custom_dialog_filter.dart';
import 'notas_entrada_pendente_controller.dart';

class NotasEntradaPendentePage extends StatefulWidget {
  const NotasEntradaPendentePage({super.key});

  @override
  State<NotasEntradaPendentePage> createState() =>
      _NotasEntradaPendentePageState();
}

class _NotasEntradaPendentePageState
    extends PdvState<NotasEntradaPendentePage, NotasEntradaPendenteController> {
  @override
  void initState() {
    super.initState();

    NotasEntradaPendenteBindings().dependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (_, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Container(
              padding: const EdgeInsets.all(8),
              color: const Color(0xFFD9D9D9),
              height: MediaQuery.of(context).size.height * 0.90,
              child: Column(
                children: [
                  Expanded(
                    child: Obx(() {
                      return controller.listaNotas.isNotEmpty
                          ? ListView.separated(
                              shrinkWrap: false,
                              itemCount: controller.listaNotas.length,
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                    height: 10,
                                  ),
                              itemBuilder: (BuildContext context, int index) {
                                final nota = controller.listaNotas[index];

                                final dateTime = nota.data.split('-');
                                final dataNota =
                                    '${dateTime[2]}/${dateTime[1]}/${dateTime[0]}';
                                return InkWell(
                                  onTap: () async {
                                    List<ItemNotaEntradaModel> item =
                                        await controller
                                            .verificaItensNota(nota.id);
                                    if (item.isEmpty) {
                                      // ignore: use_build_context_synchronously
                                      // var res = await Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           const SimpleBarcodeScannerPage(),
                                      //     ));

                                      var res = await Get.to(() =>
                                          const BarcodeScannerWithScanWindow());
                                      if (res != '-1') {
                                        final pesquisa = res;

                                        if (pesquisa.isNotEmpty) {
                                          controller.setCodBarProd = pesquisa;

                                          controller.insertProduto(
                                              ItemNotaEntradaModel(
                                                  id: 0,
                                                  idNota: nota.id,
                                                  codBarras: res,
                                                  quantidade: controller
                                                      .quantidade.value),
                                              nota);
                                        }
                                      }
                                    } else {
                                      Get.toNamed('/conferencia_nota',
                                          arguments: nota);
                                    }
                                  },
                                  child: Container(
                                    height: 90,
                                    padding: const EdgeInsets.all(5),
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        nota.status == 'N'
                                            ? Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: const FaIcon(
                                                  FontAwesomeIcons
                                                      .circleExclamation,
                                                  color: Colors.red,
                                                  size: 30,
                                                ),
                                              )
                                            : const SizedBox(),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Data: $dataNota",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                nota.fornecedor,
                                                maxLines: 2,
                                                softWrap: true,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })
                          : const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.shopSlash,
                                    size: 50,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Nenhuma nota para conferir',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                    }),
                  ),
                  Obx(() {
                    return Visibility(
                        visible: controller.visible.value,
                        child: Container(
                          height: 75,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.blue[700]!,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Filtro de data',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Obx(() {
                                      return Text(
                                        '${controller.dataInicioFiltro} - ${controller.dataFimFiltro}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ));
                  })
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () async {
          // showDialog(
          //     context: context, builder: (_) => const CustomDialogFilter());
          if (controller.visible.value) {
            controller.heightDefault.value = 0.83;
            controller.visible.value = false;

            controller.clearFilterData();
          } else {
            controller.heightDefault.value = 0.73;
            controller.visible.value = true;
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return CustomDialogFilter(
                  inputDataInicioEC: controller.inputDataInicioEC,
                  inputDataFimEC: controller.inputDataFimEC,
                  confirmFilterData: () {
                    if (controller.inputDataInicioEC.text != '' &&
                        controller.inputDataFimEC.text != '') {
                      controller.filterDateList();
                    } else {
                      controller.messagePreencherDadas();
                    }
                  },
                  cancelFilterData: () {
                    controller.clearFilterData();
                    Get.back();
                  },
                );
              },
            );
          }
        },
        tooltip: 'Filtro',
        child: Obx(() {
          return controller.visible.value
              ? const Icon(
                  Icons.clear_sharp,
                  color: Colors.white,
                )
              : const Icon(
                  Icons.search,
                  color: Colors.white,
                );
        }),
      ),
    );
  }
}
