import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../../firebase_options.dart';

class AppConfig {
  /// Initialize any other providers
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await AppConfig.initFirebase();
  }

  /// Initialize firebase connection
  static Future<void> initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
