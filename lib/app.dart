import 'package:flutter/material.dart';

import 'src/core/routes.dart';
import 'src/pages/splash/splash.dart';
import 'src/utils/theme.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppRoutes.navigatorKey,
      scaffoldMessengerKey: AppRoutes.scaffoldMessengerKey,
      onGenerateRoute: AppRoutes.pages,
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      title: 'Social App',
      home: const SplashPage(),
    );
  }
}
