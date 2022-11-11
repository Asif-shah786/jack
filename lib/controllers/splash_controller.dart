import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class SplashController extends GetxController{


  @override
  void onInit() {
checkAuth();
    super.onInit();
  }
  void checkAuth() {
    Future.delayed(const Duration(seconds: 15), () {
      Get.offAllNamed("/quotes");
    });
  }
}