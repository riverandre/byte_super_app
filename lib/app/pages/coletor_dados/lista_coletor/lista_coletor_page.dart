import 'package:byte_super_app/app/core/ui/widgets/custom_dialog_produto.dart';
import 'package:byte_super_app/app/core/ui/widgets/dialog_informa_quantidade.dart';
import 'package:byte_super_app/app/pages/conferencia_nota/widget/custom_dialog_remove.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './lista_coletor_controller.dart';

class ListaColetorPage extends GetView<ListaColetorController> {
  const ListaColetorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final valorQtdEC = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Produtos',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        toolbarHeight: 50,
        elevation: 2,
        backgroundColor: Colors.blue,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 1,
                child: Text('Restaurar dados enviados'),
              ),
              const PopupMenuItem(
                value: 2,
                child: Text('Excluir enviados'),
              ),
              const PopupMenuItem(
                value: 3,
                child: Text('Excluir todos'),
              )
            ],
            onSelected: (value) async {
              if (value == 1) {
                await controller.restauraDadosEnviados();
              } else if (value == 2) {
                await controller.excluiEnviados();
              } else if (value == 3) {
                await controller.excluiTodos();
              }
            },
          )
        ],
      ),
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
                  Expanded(child: Obx(() {
                    return controller.listaColetor.isNotEmpty
                        ? ListView.separated(
                            shrinkWrap: false,
                            itemCount: controller.listaColetor.length,
                            separatorBuilder: (context, index) => const Divider(
                              height: 10,
                            ),
                            itemBuilder: (context, index) {
                              final produto = controller.listaColetor[index];
                              return InkWell(
                                onTap: () {
                                  controller.qtdd.value = produto.qtdd;
                                  showDialog(
                                    //-------- DIALOG CONFIRMA PRODUTO CARRINHO COM QTD
                                    barrierDismissible:
                                        true, //- para não fechar o dialog quando clicar fora
                                    context: context,
                                    builder: (_) {
                                      return Obx(
                                        () => CustomDialogProduto(
                                          codBarras: produto.codBarras,
                                          quantidade: controller.qtdd.value,
                                          addQtdProd: () =>
                                              controller.qtdd.value++,
                                          removeQtProd: () =>
                                              controller.qtdd.value > 1
                                                  ? controller.qtdd.value--
                                                  : controller.qtdd.value,
                                          editQuantidade: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return DialogInformaQuantidade(
                                                    valorQtdEC: valorQtdEC,
                                                    salvarValorQtd: () {
                                                      final valor =
                                                          valorQtdEC.text;
                                                      if (valor.isNotEmpty &&
                                                          valor != '0') {
                                                        controller.qtdd.value =
                                                            double.parse(valor);

                                                        Get.back();
                                                        controller
                                                            .insereCodBarrasColetor(
                                                                produto
                                                                    .codBarras);
                                                        controller.qtdd.value =
                                                            1.00;
                                                        Get.back();
                                                      }
                                                    });
                                              },
                                            );
                                          },
                                          addProdNota: () {
                                            Get.back();
                                            controller.insereCodBarrasColetor(
                                                produto.codBarras);
                                            controller.qtdd.value = 1.00;
                                          },
                                          voltaoBotao: () {
                                            Get.back();
                                            controller.qtdd.value = 1.00;
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                                onLongPress: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CustomDialogRemove(
                                            removeProd: () {
                                          controller
                                              .removeProdutoLista(produto);
                                          Get.back();
                                        });
                                      });
                                },
                                child: Container(
                                  height: 70,
                                  padding: const EdgeInsets.all(5),
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              const Text('Cód Barras: ',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              Text(
                                                produto.codBarras,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text('Quantidade: ',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              Text(
                                                '${produto.qtdd}',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
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
                                  'Nenhum produto conferido',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                  }))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
