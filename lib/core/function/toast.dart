import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

showToast({required String msg}) {
  return Fluttertoast.showToast(
    msg: 'لا يمكن فتح هذا الموقع',
    backgroundColor: Theme.of(Get.context!).colorScheme.background,
  );
}
