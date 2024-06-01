import 'package:byte_super_app/app/core/ui/widgets/custom_dialog_produto.dart';
import 'package:byte_super_app/app/models/conferencia/item_nota_entrada_model.dart';
import 'package:byte_super_app/app/pages/conferencia_nota/widget/custom_dialog_confirm_send.dart';
import 'package:byte_super_app/app/pages/conferencia_nota/widget/custom_dialog_remove.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import './conferencia_nota_controller.dart';

class ConferenciaNotaPage extends GetView<ConferenciaNotaController> {
  const ConferenciaNotaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final valorQtdEC = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        toolbarHeight: 50,
        elevation: 2,
        title: Obx(() {
          return Text(
            controller.titleAppBar.value,
            style: const TextStyle(
              color: Colors.white,
            ),
          );
        }),
        actions: [
          Obx(
            () => Visibility(
              visible: !controller.notaEnviada.value,
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CustomDialogConfirmSend(
                        sendValue: () {
                          Get.back();
                          controller.sendNota();
                        },
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (_, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.grey[500],
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.09,
                  child: const Center(
                    child: Text(
                      'Itens da Nota',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Fornecedor: ${controller.notaEntrada.fornecedor}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                    maxLines: 3,
                  ),
                ),
                Expanded(
                  child: Obx(() {
                    return ListView.separated(
                      shrinkWrap: false,
                      itemCount: controller.listaItens.length,
                      separatorBuilder: (context, index) => const Divider(
                        height: 10,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        final item = controller.listaItens[index];

                        return InkWell(
                          onLongPress: () {
                            !controller.notaEnviada.value
                                ? showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CustomDialogRemove(removeProd: () {
                                        controller.removeProdutoLista(item);
                                        Get.back();
                                      });
                                    },
                                  )
                                : const SizedBox();
                          },
                          onTap: () {
                            controller.qtdProduto.value = item.quantidade;
                            // ignore: use_build_context_synchronously
                            !controller.notaEnviada.value
                                ? showDialog(
                                    //-------- DIALOG CONFIRMA PRODUTO CARRINHO COM QTD
                                    barrierDismissible:
                                        true, //- para não fechar o dialog quando clicar fora
                                    context: context,
                                    builder: (_) {
                                      return Obx(
                                        () => CustomDialogProduto(
                                          codBarras: item.codBarras,
                                          quantidade:
                                              controller.qtdProduto.value,
                                          addQtdProd: () =>
                                              controller.qtdProduto.value++,
                                          removeQtProd: () =>
                                              controller.qtdProduto.value > 1
                                                  ? controller
                                                      .qtdProduto.value--
                                                  : controller.qtdProduto.value,
                                          editQuantidade: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Dialog(
                                                  child: Container(
                                                    height: 200,
                                                    width: 100,
                                                    decoration: ShapeDecoration(
                                                      color: Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(34),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Column(
                                                        children: [
                                                          const Text(
                                                              'Informe a quantidade desejada',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child:
                                                                TextFormField(
                                                              autofocus: true,
                                                              controller:
                                                                  valorQtdEC,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .phone,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              final valor =
                                                                  valorQtdEC
                                                                      .text;
                                                              if (valor
                                                                      .isNotEmpty &&
                                                                  valor !=
                                                                      '0') {
                                                                controller
                                                                        .qtdProduto
                                                                        .value =
                                                                    double.parse(
                                                                        valor);

                                                                Get.back();
                                                                controller.alteraProduto(ItemNotaEntradaModel(
                                                                    id: item.id,
                                                                    idNota: item
                                                                        .idNota,
                                                                    codBarras: item
                                                                        .codBarras,
                                                                    quantidade: controller
                                                                        .qtdProduto
                                                                        .value));
                                                                controller
                                                                    .qtdProduto
                                                                    .value = 0;
                                                                Get.back();
                                                              }
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
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
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          addProdNota: () {
                                            Get.back();
                                            controller.alteraProduto(
                                                ItemNotaEntradaModel(
                                                    id: item.id,
                                                    idNota: item.idNota,
                                                    codBarras: item.codBarras,
                                                    quantidade: controller
                                                        .qtdProduto.value));
                                            controller.qtdProduto.value = 0;
                                          },
                                          voltaoBotao: () {
                                            Get.back();
                                            controller.qtdProduto.value = 0;
                                          },
                                        ),
                                      );
                                    })
                                : const SizedBox();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: ShapeDecoration(
                              color: Colors.grey[200],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Produto: ${item.codBarras}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Quantidade: ${item.quantidade}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: Obx(() => Visibility(
            visible: !controller.notaEnviada.value,
            child: FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () async {
                var res = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SimpleBarcodeScannerPage(),
                    ));
                // var res = '7890000000109';

                if (res != '-1') {
                  if (res.isNotEmpty) {
                    await controller.verificaProduto(res);
                    if (controller.prodCadastrado) {
                      controller.alteraProduto(ItemNotaEntradaModel(
                          id: controller.itemNota.id,
                          idNota: controller.itemNota.idNota,
                          codBarras: controller.itemNota.codBarras,
                          quantidade: controller.itemNota.quantidade + 1));
                      controller.qtdProduto.value = 0;
                    } else {
                      controller.insertProduto(ItemNotaEntradaModel(
                          id: 0,
                          idNota: controller.notaEntrada.id,
                          codBarras: res,
                          quantidade: 1));
                    }
                  }
                }
              },
              tooltip: 'Adicionar',
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          )),
    );
  }
}
