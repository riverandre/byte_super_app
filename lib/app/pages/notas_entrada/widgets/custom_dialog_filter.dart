import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDialogFilter extends StatelessWidget {
  final TextEditingController inputDataInicioEC;
  final TextEditingController inputDataFimEC;
  final VoidCallback confirmFilterData;
  final VoidCallback cancelFilterData;

  const CustomDialogFilter({
    super.key,
    required this.inputDataInicioEC,
    required this.inputDataFimEC,
    required this.confirmFilterData,
    required this.cancelFilterData,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 100,
        height: 300,
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
                'Selecione as datas para filtrar',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: inputDataInicioEC,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Data Inicial" //label text of field
                      ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        locale: const Locale('pt', 'BR'),
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2023),
                        builder: (context, child) {
                          return Theme(
                            data: ThemeData
                                .light(), // This will change to light theme.
                            child: child!,
                          );
                        },
                        lastDate: DateTime(2100));

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('dd/MM/yyyy').format(pickedDate);

                      inputDataInicioEC.text =
                          formattedDate; //set output date to TextField value.
                    } else {}
                  },
                ),
              ),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: inputDataFimEC,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Data Final" //label text of field
                      ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2023),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2100));

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('dd/MM/yyyy').format(pickedDate);

                      inputDataFimEC.text =
                          formattedDate; //set output date to TextField value.
                    } else {}
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 40,
                    width: 110,
                    child: ElevatedButton(
                      onPressed: cancelFilterData,
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
                    width: 110,
                    child: ElevatedButton(
                      onPressed: confirmFilterData,
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(const Color(0xA5D0FFC4))),
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
            ])),
      ),
    );
  }
}
