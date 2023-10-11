import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k_news/core/services/services.dart';
import 'package:k_news/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(
          // primarySwatch: Colors.blue,
          ),
      getPages: routes,
    );
  }
}
