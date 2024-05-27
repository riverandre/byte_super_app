import 'package:flutter/material.dart';

class HeadTabs extends StatelessWidget {
  final bool tabUsedPendente;
  final bool tabUsedEnviado;
  final VoidCallback toggleTabPendente;
  final VoidCallback toggleTabEnviado;
  const HeadTabs({
    super.key,
    required this.tabUsedPendente,
    required this.tabUsedEnviado,
    required this.toggleTabPendente,
    required this.toggleTabEnviado,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 48,
        margin: const EdgeInsets.only(bottom: 0),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.5),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: toggleTabPendente,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.45,
                height: 40,
                margin: const EdgeInsets.only(bottom: 0),
                padding: const EdgeInsets.all(0),
                decoration: tabUsedPendente
                    ? BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: const Offset(0, 2),
                            )
                          ])
                    : const BoxDecoration(),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Pendentes',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: toggleTabEnviado,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.45,
                height: 40,
                margin: const EdgeInsets.only(bottom: 0),
                padding: const EdgeInsets.all(0),
                decoration: tabUsedEnviado
                    ? const BoxDecoration()
                    : BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: const Offset(0, 2),
                            )
                          ]),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Enviados',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
