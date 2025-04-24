import 'package:flutter/material.dart';
import 'package:get/get.dart';

showMessage(String message) {
  return Get.snackbar(
    'CommZy',
    message,
    backgroundColor: const Color(0xffFC4F00),
    colorText: Colors.white,
  );
}
