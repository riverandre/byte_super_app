import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/auth_service.dart';
import 'pdv_button_widget.dart';

// ignore: must_be_immutable
class PdvAppbar extends AppBar {
  Widget titulo;
  bool logOut;
  bool remove;
  VoidCallback? onPress;
  VoidCallback? onPressDelete;
  PdvAppbar({
    super.key,
    required this.titulo,
    this.onPress,
    this.remove = false,
    this.onPressDelete,
    this.logOut = false,
  }) : super(
            backgroundColor: Colors.blue,
            toolbarHeight: 50,
            elevation: 2,
            title: titulo,
            leading: logOut
                ? Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Image.asset(
                      'assets/images/logo_sem_text.png',
                    ),
                  )
                : BackButton(
                    onPressed: onPress,
                  ),
            actions: [
              Visibility(
                visible: !remove,
                child: logOut
                    ? IconButton(
                        onPressed: () {
                          Get.defaultDialog(
                            title: 'Sair',
                            titlePadding: const EdgeInsets.all(10),
                            onWillPop: () async {
                              return false;
                            },
                            titleStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                            backgroundColor: Colors.blue,
                            content: const Center(
                              child: Text(
                                'Deseja realmente retornar ao login?',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            cancel: PdvButtonWidget(
                              label: 'Não',
                              color: Colors.red,
                              onPressed: () {
                                Get.back();
                              },
                            ),
                            confirm: PdvButtonWidget(
                              label: 'Sim',
                              color: Colors.green,
                              onPressed: () {
                                final auth = AuthService();
                                auth.logout();
                                // Get.offAndToNamed('/auth/login');
                                Get.offAllNamed('/auth/login');
                              },
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.logout_outlined,
                          size: 30,
                          color: Colors.white,
                        ),
                      )
                    : IconButton(
                        onPressed: onPressDelete,
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
              )
            ]);
}
