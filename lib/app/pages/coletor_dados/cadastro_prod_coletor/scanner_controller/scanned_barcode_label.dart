import 'package:byte_super_app/app/core/ui/widgets/pdv_button_widget.dart';
import 'package:byte_super_app/app/core/ui/widgets/pdv_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannedBarcodeLabel extends StatefulWidget {
  const ScannedBarcodeLabel({
    super.key,
    required this.barcodes,
  });

  final Stream<BarcodeCapture> barcodes;

  @override
  State<ScannedBarcodeLabel> createState() => _ScannedBarcodeLabelState();
}

class _ScannedBarcodeLabelState extends State<ScannedBarcodeLabel> {
  @override
  Widget build(BuildContext context) {
    final codBarEC = TextEditingController();

    return StreamBuilder(
      stream: widget.barcodes,
      builder: (context, snapshot) {
        final scannedBarcodes = snapshot.data?.barcodes ?? [];

        if (scannedBarcodes.isEmpty) {
          return PdvButtonWidget(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return Dialog(
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(34),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                'Informe o código de barras',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              PdvTextformfield(
                                label: '',
                                controller: codBarEC,
                                enabledValue: true,
                                readyOnly: false,
                                autofocus: true,
                                inputType: TextInputType.number,
                              ),
                              PdvButtonWidget(
                                  onPressed: () {
                                    Get.back();
                                    Navigator.pop(context, codBarEC.text);
                                  },
                                  color: Colors.blueAccent,
                                  colorText: Colors.white,
                                  label: 'Confirmar')
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              label: 'digitar código de barras');
        } else {
          // Get.back(result: scannedBarcodes.first.displayValue);
          Navigator.pop(context, scannedBarcodes.first.displayValue);
          return const SizedBox();
        }

        // return Text(
        //   scannedBarcodes.first.displayValue ?? 'No display value.',
        //   overflow: TextOverflow.fade,
        //   style: const TextStyle(color: Colors.white),
        // );
      },
    );
  }
}
