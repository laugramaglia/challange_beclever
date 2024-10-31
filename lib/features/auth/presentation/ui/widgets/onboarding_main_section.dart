import 'package:challange_beclever/core/theme/extensions/theme_buttons_extension.dart';
import 'package:challange_beclever/core/utils/extensions/context.dart';
import 'package:flutter/material.dart';

class OnboardingMainSection extends StatelessWidget {
  final String? titleLabel, descriptionLabel;
  final List<Widget> children;
  final void Function()? onPressedFloatingActionButton;
  const OnboardingMainSection({
    super.key,
    this.titleLabel,
    this.descriptionLabel,
    required this.children,
    this.onPressedFloatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          height: 56,
          child: ElevatedButton(
            onPressed: onPressedFloatingActionButton,
            style: context.theme.buttonFilled,
            child: const Center(child: Text('Continuar')),
          ),
        ),
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
