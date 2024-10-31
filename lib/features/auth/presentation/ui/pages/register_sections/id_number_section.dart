import 'package:challange_beclever/features/auth/presentation/bloc/register_user/register_user_cubit.dart';
import 'package:challange_beclever/features/auth/presentation/bloc/stepper_index/stepper_index_cubit.dart';
import 'package:challange_beclever/features/auth/presentation/ui/widgets/onboarding_main_section.dart';
import 'package:challange_beclever/features/auth/presentation/ui/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IdNumberSection extends StatelessWidget {
  const IdNumberSection({super.key});

  @override
  Widget build(BuildContext context) {
    final userState = context.watch<RegisterUserCubit>().state;
    return OnboardingMainSection(
        key: const ValueKey('id-number'),
        titleLabel: 'Ingresa tu número de cédula',
        onPressedFloatingActionButton: userState.idNumber.isEmpty
            ? null
            : () => context.read<StepperIndexCubit>().nextPage(3),
        children: [
          TextFieldWidget(
            initialValue: userState.idNumber,
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
            onChange: (value, error) {
              if (error == null && value.isNotEmpty) {
                context.read<RegisterUserCubit>().updateIdNumber(value);
              } else if (userState.idNumber.isNotEmpty) {
                context.read<RegisterUserCubit>().updateIdNumber('');
              }
            },
          )
        ]);
  }
}
