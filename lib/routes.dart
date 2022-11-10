import 'package:get/get.dart';
import 'package:jack/page/home_page.dart';
import 'package:jack/page/splash.dart';

import 'bindings.dart';

class Routes{
  static final pages=[
    GetPage(name: "/", page: () => const SplashScreen(), binding: SplashBinding()),
    GetPage(name: "/home_page", page: () =>  HomePage(),),

  ];
}