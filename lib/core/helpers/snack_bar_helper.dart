import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SnackBarHelper {
  static const double _maxWidth = 600;
  static const double _borderRadius = 12;
  static const double _margin = 16;
  static const SnackPosition _snackPosition = SnackPosition.TOP;

  static void showError(String message) {
    Get.snackbar(
      "",
      "",
      icon: const Icon(Icons.error, color: Colors.white),
      titleText: Text(
        "error".tr,
        style: const TextStyle(color: Colors.white),
      ),
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      snackPosition: _snackPosition,
      maxWidth: _maxWidth,
      backgroundColor: Colors.red.withOpacity(0.6),
      barBlur: 3,
      margin: const EdgeInsets.all(_margin),
      borderRadius: _borderRadius,
    );
  }

  static void showInfo(String message) {
    Get.snackbar(
      "",
      "",
      icon: const Icon(Icons.info, color: Colors.white),
      titleText: Text(
        "info".tr,
        style: const TextStyle(color: Colors.white),
      ),
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      snackPosition: _snackPosition,
      maxWidth: _maxWidth,
      backgroundColor: Colors.blue.withOpacity(0.6), // Light blue color
      barBlur: 3,
      margin: const EdgeInsets.all(_margin),
      borderRadius: _borderRadius,
    );
  }

  static void showWarning(String message) {
    Get.snackbar(
      "",
      "",
      icon: const Icon(Icons.warning, color: Colors.white),
      titleText: Text(
        "warning".tr,
        style: const TextStyle(color: Colors.white),
      ),
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      snackPosition: _snackPosition,
      maxWidth: _maxWidth,
      backgroundColor: Colors.amber.withOpacity(0.6), // Light orange color
      barBlur: 3,
      margin: const EdgeInsets.all(_margin),
      borderRadius: _borderRadius,
    );
  }

  static void showSuccess(String message) {
    Get.snackbar(
      "",
      "",
      icon: const Icon(Icons.check_circle, color: Colors.white),
      titleText: Text(
        "success".tr,
        style: const TextStyle(color: Colors.white),
      ),
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      snackPosition: _snackPosition,
      maxWidth: _maxWidth,
      backgroundColor: Colors.green.withOpacity(0.6), // Light green color
      barBlur: 3,
      margin: const EdgeInsets.all(_margin),
      borderRadius: _borderRadius,
    );
  }
}
