import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../core/ui/pdv_state.dart';
import '../../core/ui/widgets/application_responsive_widget.dart';
import 'splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends PdvState<SplashPage, SplashController> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 8)).then((value) {
      Get.offNamed('/auth/login');
      //controller.checkLogged();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ApplicationResponsiveWidget responsiveWidget =
        ApplicationResponsiveWidget.of(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Lottie.asset(
                'assets/images/drbyte_splash.json',
                width: responsiveWidget.widthPercentual(50),
                height: responsiveWidget.heightPercentual(50),
              ),
              //   Image.asset(
              //     'assets/images/globe.png',
              //     width: 100,
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // ElevatedButton(
              //   onPressed: () {},
              //   child: const Text('Acessar'),
            )
          ],
        ),
      ),
    );
  }
}
