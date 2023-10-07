import 'package:flutter/material.dart';

import '../core/routes.dart';
// Method to showsnackbar
void showSnackbar(String message) {
  AppRoutes.scaffoldMessengerKey.currentState!.showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
