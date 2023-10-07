import 'package:flutter/material.dart';

import '../core/routes.dart';

void showSnackbar(String message) {
  AppRoutes.scaffoldMessengerKey.currentState!.showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
