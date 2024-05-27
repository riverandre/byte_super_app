import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class PdvState<S extends StatefulWidget, C extends GetxController>
    extends State<S> {
  C get controller => Get.find();
  // late final C controller;

  // @override
  // void initState() {
  //   super.initState();
  //   controller = Get.find<C>();

  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     onReady();
  //   });
  // }

  // void onReady() {}
}
