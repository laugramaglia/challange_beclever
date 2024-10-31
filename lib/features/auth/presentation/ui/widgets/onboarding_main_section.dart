import 'package:challange_beclever/core/utils/extensions/context.dart';
import 'package:flutter/material.dart';

class OnboardingMainSection extends StatelessWidget {
  final String? titleLabel, descriptionLabel;
  final List<Widget> children;
  const OnboardingMainSection(
      {super.key,
      this.titleLabel,
      this.descriptionLabel,
      required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
