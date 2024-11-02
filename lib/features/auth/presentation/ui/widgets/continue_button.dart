import 'package:challange_beclever/core/theme/extensions/theme_buttons_extension.dart';
import 'package:challange_beclever/core/utils/extensions/context.dart';
import 'package:flutter/material.dart';

class Continuebutton extends StatelessWidget {
  final String? secondaryButtonLabel;
  final void Function()? secondaryOnPressed;
  final String label;
  final void Function()? onPressed;
  const Continuebutton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.secondaryButtonLabel,
      this.secondaryOnPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (secondaryButtonLabel case final secondaryButtonLabel?)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: TextButton(
                onPressed: secondaryOnPressed,
                child: Text(secondaryButtonLabel,
                    style: context.theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.colorScheme.primary,
                      fontSize: 18,
                    ))),
          ),
        SizedBox(
          height: 56,
          width: double.maxFinite,
          child: ElevatedButton(
            style: context.theme.buttonFilled,
            onPressed: onPressed,
            child: Text(label),
          ),
        ),
      ],
    );
  }
}
