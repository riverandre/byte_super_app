import 'package:flutter/material.dart';

import 'pdv_rounded_button.dart';

class PlusMinusBox extends StatelessWidget {
  final bool elevated;
  final Color? backgroundColor;
  final String? label;
  final double quantity;

  final VoidCallback minusCallBack;
  final VoidCallback plusBallBack;
  final VoidCallback editQuantidadeCallBack;
  final bool calculateTotal;

  const PlusMinusBox({
    super.key,
    required this.quantity,
    required this.minusCallBack,
    required this.plusBallBack,
    required this.editQuantidadeCallBack,
    this.elevated = false,
    this.backgroundColor,
    this.label,
    this.calculateTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PdvRoundedButton(
                  onPressed: minusCallBack,
                  label: '-',
                  fontSize: 22,
                  color: const Color(0xFFFF0000),
                ),
                InkWell(
                  onTap: editQuantidadeCallBack,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      '$quantity',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                PdvRoundedButton(
                  onPressed: plusBallBack,
                  label: '+',
                  fontSize: 22,
                  color: Colors.blue,
                ),
              ],
            ),
            // Visibility(
            //   visible: label == null,
            //   child: const Spacer(),
            // ),
            // Container(
            //   margin: const EdgeInsets.only(left: 20, right: 20),
            //   constraints: const BoxConstraints(minWidth: 70),
            //   child: Text(FormatterHelper.formatCurrency(
            //     calculateTotal ? price * quantity : price,
            //   )),
            // )
          ],
        ),
      ),
    );
  }
}
