import 'package:flutter/material.dart';
import 'package:social_app/src/utils/app_color.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    // Returns loading
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.secondaryColor,
      ),
    );
  }
}
