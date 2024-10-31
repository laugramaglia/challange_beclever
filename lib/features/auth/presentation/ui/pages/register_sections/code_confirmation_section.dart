import 'package:challange_beclever/core/utils/extensions/context.dart';
import 'package:challange_beclever/features/auth/presentation/ui/widgets/onboarding_main_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CodeConfirmationSection extends StatelessWidget {
  const CodeConfirmationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingMainSection(
        titleLabel: 'Ingresa el código',
        descriptionLabel: 'El numero de cuatro digitos que enviamos al ......',
        children: [
          PinCodeTextField(
            appContext: context,
            length: 4,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            pinTheme: PinTheme.defaults(
              selectedColor: context.colorScheme.primary,
              inactiveColor: Colors.grey,
              activeColor: Colors.grey,
              fieldWidth: 55,
            ),
            onCompleted: (value) {},
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Podras reenviar el codigo en 00:00',
                style: context.theme.textTheme.bodySmall),
          ),
        ]);
  }
}
