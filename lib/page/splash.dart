import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration:const BoxDecoration(
          color: Colors.white
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("assets/lf20_3lr9fsii.json",fit: BoxFit.contain,height: 200,width: 200),
             const Text("Getting Jack ready...",style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.w500
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
