// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

mixin LoaderMixin on GetxController {
  void loaderListener(
    RxBool loading,
  ) {
    ever(loading, (_) async {
      if (loading.isTrue) {
        await Get.dialog(
            WillPopScope(
              onWillPop: () async =>
                  false, // não deixa o usuário fechar o modal
              child: Center(
                child: LoadingAnimationWidget.inkDrop(
                  color: Colors.blueAccent,
                  size: 50,
                ),
                // child: CircularProgressIndicator(
                //   color: Colors.blueAccent,
                //   strokeWidth: 4,
                // ),
              ),
            ),
            barrierDismissible: false);
      } else {
        Get.back();
      }
    });
  }
}
