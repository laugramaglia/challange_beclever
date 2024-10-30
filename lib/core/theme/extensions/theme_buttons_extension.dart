import 'package:flutter/material.dart';

extension ThemeButtonsExtension on ThemeData {
  ButtonStyle get buttonOutline =>
      _baseButton(backgroundColor: colorScheme.onPrimary);

  ButtonStyle get buttonFilled => _baseButton(
      backgroundColor: colorScheme.primary, txtColor: colorScheme.onPrimary);

  ButtonStyle _baseButton({required Color backgroundColor, Color? txtColor}) =>
      ElevatedButton.styleFrom(
        iconColor: txtColor,
        foregroundColor: txtColor,
        textStyle: textTheme.bodyLarge
            ?.copyWith(fontWeight: FontWeight.bold, height: 3),
        backgroundColor: backgroundColor,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide(
          color: colorScheme.primary,
        ),
      );
}
