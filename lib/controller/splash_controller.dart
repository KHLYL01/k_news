import 'package:get/get.dart';
import 'package:k_news/core/constantes/app_route.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    Future.delayed(
      const Duration(seconds: 3),
      () => Get.offNamed(AppRoute.news),
    );
    super.onInit();
  }
}
