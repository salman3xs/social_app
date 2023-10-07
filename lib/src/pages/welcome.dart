import 'package:flutter/material.dart';
import 'package:social_app/src/utils/extensions.dart';

import '../core/routes.dart';
import '../utils/app_color.dart';
import '../utils/paddings.dart';
import '../utils/sizes.dart';
import 'auth/login_page.dart';
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: Paddings.p16,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 1),
            Sizes.h36,
            Text('Welcome', style: context.hl),
            Sizes.h8,
            Text(
              "Social App",
              style: context.lm.copyWith(
                color: AppColors.secondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(flex: 1),
            Hero(
              tag: 'login',
              child: ElevatedButton(
                onPressed: () => AppRoutes.push(page: LoginPage()),
                child: const Text("Get Started"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
