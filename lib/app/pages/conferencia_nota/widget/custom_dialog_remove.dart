import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialogRemove extends StatelessWidget {
  final VoidCallback removeProd;

  const CustomDialogRemove({super.key, required this.removeProd});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 100,
        height: 250,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(34),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Deseja remover esse produto ?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 10.0, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 80,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.red[100]),
                        ),
                        child: const Text(
                          'Não',
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
                      width: 80,
                      child: ElevatedButton(
                        onPressed: removeProd,
                        style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                const Color(0xA5D0FFC4))),
                        child: const Text(
                          'Sim',
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
