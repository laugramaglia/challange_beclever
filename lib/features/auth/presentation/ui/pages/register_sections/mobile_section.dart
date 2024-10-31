import 'package:challange_beclever/features/auth/presentation/bloc/register_user/register_user_cubit.dart';
import 'package:challange_beclever/features/auth/presentation/bloc/stepper_index/stepper_index_cubit.dart';
import 'package:challange_beclever/features/auth/presentation/ui/widgets/onboarding_main_section.dart';
import 'package:challange_beclever/features/auth/presentation/ui/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MobileSection extends StatelessWidget {
  const MobileSection({super.key});

  @override
  Widget build(BuildContext context) {
    final userState = context.watch<RegisterUserCubit>().state;
    return OnboardingMainSection(
        key: const ValueKey('mobile'),
        titleLabel: 'Ingresa tu número de teléfono móvil',
        descriptionLabel: 'Te enviaremos un SMS con código de cuatro digitos',
        onPressedFloatingActionButton: userState.pohneNumber.isEmpty
            ? null
            : () => context.read<StepperIndexCubit>().nextPage(3),
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
            onChange: (value, error) {
              if (error == null && value.isNotEmpty) {
                context.read<RegisterUserCubit>().updatePhoneNumber(value);
              } else if (userState.pohneNumber.isNotEmpty) {
                context.read<RegisterUserCubit>().updatePhoneNumber('');
              }
            },
          )
        ]);
  }
}
