import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:social_app/src/core/firebase_config.dart';
import 'app.dart';
// This function is the entry point for the app.
void main() async {
  // Initialize Firebase.
  await FireabaseConfig.init();

  // Run the app.
  runApp(const App());
}

// This class represents the root widget of the app.
class App extends StatelessWidget {
  // The constructor.
  const App({super.key});

  // The build method.
  @override
  Widget build(BuildContext context) {
    // Return the ProviderScope widget with the MainApp widget as its child.
    // The ProviderScope widget provides dependency injection for the app.
    return const ProviderScope(
      child: MainApp(),
    );
  }
}