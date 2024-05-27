import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../core/ui/widgets/plus_minus_box.dart';

// ignore: must_be_immutable
class CustomDialogProduto extends StatelessWidget {
  String codBarras;
  double quantidade;
  final VoidCallback addProdNota;
  final VoidCallback editQuantidade;
  final VoidCallback addQtdProd;
  final VoidCallback removeQtProd;
  final VoidCallback voltaoBotao;
  final FocusNode? focus;
  final String? caminho;

  CustomDialogProduto({
    super.key,
    required this.codBarras,
    required this.quantidade,
    required this.addProdNota,
    required this.addQtdProd,
    required this.removeQtProd,
    required this.voltaoBotao,
    required this.editQuantidade,
    this.caminho = '',
    this.focus,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        if (caminho!.isNotEmpty) {
          Get.offAndToNamed(caminho!);
          return true;
        }
        return false;
      },
      child: Dialog(
        child: Container(
            width: 100,
            height: 250,
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
                    'Produto: $codBarras',
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
                  width: 370,
                  height: 100,
                  color: Colors.white,
                  child: PlusMinusBox(
                      quantity: quantidade,
                      minusCallBack: removeQtProd,
                      plusBallBack: addQtdProd,
                      editQuantidadeCallBack: editQuantidade),
                ),
                const Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10.0, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 40,
                        width: 120,
                        child: ElevatedButton(
                          onPressed: voltaoBotao,
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Colors.red[100]),
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
                          onPressed: addProdNota,
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
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
            )),
      ),
    );
  }
}
