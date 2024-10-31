import 'package:challange_beclever/features/auth/presentation/ui/widgets/onboarding_main_section.dart';
import 'package:challange_beclever/features/auth/presentation/ui/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IdNumberSection extends StatelessWidget {
  final Function(String, String?) onChange;
  const IdNumberSection({super.key, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return OnboardingMainSection(
        titleLabel: 'Ingresa tu número de cédula',
        children: [
          TextFieldWidget(
            keyboardType: TextInputType.number,
            validators: const [
              TextInputValidators.required,
              TextInputValidators.arIdNumber,
            ],
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(8),
              ThousandsSeparatorInputFormatter(),
            ],
            labelText: 'Cédula',
            onChange: onChange,
          )
        ]);
  }
}
