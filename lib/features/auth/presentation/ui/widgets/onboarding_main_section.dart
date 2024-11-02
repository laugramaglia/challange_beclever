import 'package:challange_beclever/core/utils/extensions/context.dart';
import 'package:challange_beclever/features/auth/presentation/ui/widgets/continue_button.dart';
import 'package:flutter/material.dart';

class OnboardingMainSection extends StatelessWidget {
  final String? titleLabel, descriptionLabel, secondaryButtonLabel;
  final List<Widget> children;
  final void Function()? onPressedFloatingActionButton, secondaryOnPressed;

  const OnboardingMainSection({
    super.key,
    this.titleLabel,
    this.descriptionLabel,
    required this.children,
    this.onPressedFloatingActionButton,
    this.secondaryButtonLabel,
    this.secondaryOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Continuebutton(
        onPressed: onPressedFloatingActionButton,
        label: 'Continuar',
        secondaryButtonLabel: secondaryButtonLabel,
        secondaryOnPressed: secondaryOnPressed,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (titleLabel case final titleLabel?) ...[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(titleLabel,
                  style: context.theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  )),
            ),
            const SizedBox(height: 12),
          ],
          if (descriptionLabel case final descriptionLabel?)
            Align(
                alignment: Alignment.centerLeft,
                child: Text(descriptionLabel,
                    style: context.theme.textTheme.bodyLarge)),
          const SizedBox(height: 32),
          ...children
        ],
      ),
    );
  }
}
