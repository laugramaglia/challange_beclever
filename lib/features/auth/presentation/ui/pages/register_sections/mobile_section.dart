import 'package:challange_beclever/features/auth/presentation/ui/widgets/onboarding_main_section.dart';
import 'package:challange_beclever/features/auth/presentation/ui/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MobileSection extends StatelessWidget {
  final Function(String value, String? error) onChange;
  const MobileSection({super.key, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return OnboardingMainSection(
        titleLabel: 'Ingresa tu número de teléfono móvil',
        descriptionLabel: 'Te enviaremos un SMS con código de cuatro digitos',
        children: [
          TextFieldWidget(
            keyboardType: TextInputType.number,
            validators: const [
              TextInputValidators.required,
              TextInputValidators.arMobile,
            ],
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(7),
            ],
            labelText: 'Teléfono',
            onChange: onChange,
          )
        ]);
  }
}
