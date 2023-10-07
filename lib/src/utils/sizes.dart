import 'package:flutter/material.dart';

class Sizes {
  static const w4 = SizedBox(width: 4);
  static const w8 = SizedBox(width: 8);
  static const w12 = SizedBox(width: 12);
  static const w16 = SizedBox(width: 16);
  static const w20 = SizedBox(width: 20);
  static const w24 = SizedBox(width: 24);
  static const w28 = SizedBox(width: 28);
  static const w32 = SizedBox(width: 32);
  static const w36 = SizedBox(width: 36);
  static const w40 = SizedBox(width: 40);
  static const w48 = SizedBox(width: 48);
  static const w52 = SizedBox(width: 52);
  static const w56 = SizedBox(width: 56);
  static const w64 = SizedBox(width: 64);
  static const w72 = SizedBox(width: 72);
  static const h4 = SizedBox(height: 4);
  static const h8 = SizedBox(height: 8);
  static const h12 = SizedBox(height: 12);
  static const h16 = SizedBox(height: 16);
  static const h20 = SizedBox(height: 20);
  static const h24 = SizedBox(height: 24);
  static const h28 = SizedBox(height: 28);
  static const h32 = SizedBox(height: 32);
  static const h36 = SizedBox(height: 36);
  static const h40 = SizedBox(height: 40);
  static const h44 = SizedBox(height: 44);
  static const h48 = SizedBox(height: 48);
  static const h56 = SizedBox(height: 56);
  static const h60 = SizedBox(height: 60);
  static const h64 = SizedBox(height: 64);
  static const h68 = SizedBox(height: 68);
  static const h72 = SizedBox(height: 72);
  static const h100 = SizedBox(height: 100);

  static Size textSize(String text, TextStyle style, BuildContext context) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 10,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: MediaQuery.of(context).size.width - 40);
    return textPainter.size;
  }
}
