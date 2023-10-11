import 'package:get/get.dart';
import 'package:k_news/core/constantes/app_route.dart';
import 'package:k_news/view/screen/news_home.dart';
import 'package:k_news/view/screen/splash_screen.dart';

List<GetPage> routes = [
  GetPage(name: AppRoute.splash, page: () => const SplashScreen()),
  GetPage(name: AppRoute.news, page: () => const NewsHome()),
];
