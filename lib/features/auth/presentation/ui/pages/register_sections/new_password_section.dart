import 'package:challange_beclever/core/config/router/routes.dart';
import 'package:challange_beclever/features/auth/presentation/bloc/register_user/register_user_cubit.dart';
import 'package:challange_beclever/features/auth/presentation/ui/widgets/onboarding_main_section.dart';
import 'package:challange_beclever/features/auth/presentation/ui/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPasswordSection extends StatelessWidget {
  const NewPasswordSection({super.key});

  @override
  Widget build(BuildContext context) {
    final userState = context.watch<RegisterUserCubit>().state;
    return OnboardingMainSection(
      titleLabel: 'Ingresa tu nueva contraseña',
      onPressedFloatingActionButton: !userState.isPasswordMatched
          ? null
          : () {
              const FinishRegisterRoute($extra: true).pushReplacement(context);
            },
      children: [
        TextFieldWidget(
          keyboardType: TextInputType.visiblePassword,
          validators: const [
            TextInputValidators.required,
            TextInputValidators.password
          ],
          inputFormatters: [
            FilteringTextInputFormatter.singleLineFormatter,
          ],
          labelText: 'Contraseña',
          onChange: (value, error) {
            if (error == null && value.isNotEmpty) {
              context.read<RegisterUserCubit>().updatePassword(value);
            } else if (userState.password.isNotEmpty) {
              context.read<RegisterUserCubit>().updatePassword('');
            }
          },
        ),
        const SizedBox(height: 16),
        TextFieldWidget(
          keyboardType: TextInputType.visiblePassword,
          validators: const [
            TextInputValidators.required,
            TextInputValidators.custom,
            TextInputValidators.password,
          ],
          customValidator: (value) {
            if (value != userState.password) {
              return 'La contraseña no coincide';
            }
            return null;
          },
          inputFormatters: [
            FilteringTextInputFormatter.singleLineFormatter,
          ],
          labelText: 'Repite la contraseña',
          onChange: (value, error) {
            if (error == null && value.isNotEmpty) {
              context.read<RegisterUserCubit>().updateConfirmPassword(value);
            } else if (userState.confirmPassword.isNotEmpty) {
              context.read<RegisterUserCubit>().updateConfirmPassword('');
            }
          },
        ),
      ],
    );
  }
}
