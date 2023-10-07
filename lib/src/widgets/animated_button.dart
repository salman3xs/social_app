import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../utils/app_color.dart';
//Custom animated Elevated Button
class AnimatedElevatedButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final RoundedLoadingButtonController controller;

  const AnimatedElevatedButton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.controller});

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedElevatedButtonState createState() => _AnimatedElevatedButtonState();
}

class _AnimatedElevatedButtonState extends State<AnimatedElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      controller: widget.controller,
      successColor: Colors.green,
      errorColor: Colors.red,
      borderRadius: 10,
      width: 400,
      resetAfterDuration: true,
      onPressed: widget.onPressed,
      color: AppColors.primaryColor,
      child: Text(widget.text,
          style: const TextStyle(color: AppColors.secondaryColor)),
    );
  }
}
