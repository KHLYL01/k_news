import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:k_news/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: const Alignment(0, -0.2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 200,
                  height: 100,
                  child: Image.asset("assets/images/logo.png"),
                ),
                Text(
                  "News",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
          ),
          const Align(
            alignment: Alignment(0, 0.9),
            child: FittedBox(
              child: SpinKitChasingDots(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
