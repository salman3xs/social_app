import 'package:flutter/material.dart';

import 'src/core/routes.dart';
import 'src/pages/splash/splash.dart';
import 'src/utils/theme.dart';

// This class represents the main app widget.
class MainApp extends StatelessWidget {
  // The constructor.
  const MainApp({super.key});

  // The build method.
  @override
  Widget build(BuildContext context) {
    // Return a MaterialApp widget with the following properties:
    //
    // * navigatorKey: The navigator key for the app.
    // * scaffoldMessengerKey: The scaffold messenger key for the app.
    // * onGenerateRoute: A function that is used to generate routes for the app.
    // * debugShowCheckedModeBanner: A boolean value that indicates whether to show the checked mode banner.
    // * theme: The theme for the app.
    // * title: The title of the app.
    // * home: The home page of the app.
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
