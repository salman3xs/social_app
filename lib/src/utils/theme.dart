import 'package:flutter/material.dart';
import 'app_color.dart';
import 'paddings.dart';

class Themes {
  static ThemeData get base => ThemeData.light();
  // The light theme.
  static ThemeData get light => ThemeData(
        primarySwatch:
            MaterialColor(AppColors.primaryColor.value, AppColors.color),
        textTheme: base.textTheme
            .copyWith(
                displaySmall: const TextStyle(
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                ),
                headlineLarge: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondaryColor,
                  fontSize: 28,
                ),
                headlineMedium: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondaryColor,
                  fontSize: 26,
                ),
                headlineSmall: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondaryColor,
                  fontSize: 18,
                ),
                titleLarge: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondaryColor,
                    fontSize: 18),
                titleMedium: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black45,
                    fontSize: 14), //TextFormFieldTextStyle
                titleSmall: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondaryColor,
                    fontSize: 14),
                bodyLarge: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: AppColors.secondaryColor,
                  fontSize: 20,
                ),
                bodyMedium: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryColor,
                  fontSize: 18,
                ),
                bodySmall: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryColor,
                  fontSize: 10,
                ),
                labelLarge: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryColor,
                    fontSize: 18),
                labelMedium: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.tertiaryColor,
                  fontSize: 14,
                ),
                labelSmall: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ))
            .apply(fontFamily: 'Baloo2'),
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          side: const BorderSide(
            width: 2,
            color: AppColors.secondaryColor,
          ),
          checkColor: MaterialStateProperty.all(
            AppColors.primaryColor,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: Paddings.p10,
          labelStyle: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black45),
          hintStyle: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black45),
          fillColor: AppColors.inputFilledColor,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                  color: AppColors.inputBorderColor, width: 2)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                  color: AppColors.inputBorderColor, width: 2)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                  color: AppColors.inputBorderColor, width: 2)),
        ),
        buttonTheme: const ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
          shape: StadiumBorder(),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size.fromHeight(48)),
            foregroundColor: MaterialStateProperty.all(AppColors.primaryColor),
            backgroundColor:
                MaterialStateProperty.all(AppColors.secondaryColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size.fromHeight(48)),
            foregroundColor:
                MaterialStateProperty.all(AppColors.secondaryColor),
            backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      );
}
