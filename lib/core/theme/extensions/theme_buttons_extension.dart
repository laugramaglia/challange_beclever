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
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ).copyWith(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return Colors
                  .grey[300]; // Set background color to gray when disabled
            }
            return backgroundColor; // Default background color
          },
        ),
        side: WidgetStateProperty.resolveWith<BorderSide?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return null; // Set border color to gray when disabled
            }
            return BorderSide(
                color: colorScheme.primary); // Default border color
          },
        ),
      );
}
