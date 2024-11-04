import 'package:challange_beclever/core/config/bloc/service_locator.dart';
import 'package:challange_beclever/core/config/router/routes.dart';
import 'package:challange_beclever/core/theme/mixins/loading_overlay_mixin.dart';
import 'package:challange_beclever/features/auth/presentation/bloc/auth_bloc/authentication_bloc.dart';
import 'package:challange_beclever/features/auth/presentation/bloc/biometric/biometric_dart_cubit.dart';
import 'package:challange_beclever/features/auth/presentation/bloc/register_user/register_user_cubit.dart';
import 'package:challange_beclever/features/auth/presentation/ui/widgets/onboarding_main_section.dart';
import 'package:challange_beclever/features/auth/presentation/ui/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPasswordSection extends StatefulWidget {
  const NewPasswordSection({super.key});

  @override
  State<NewPasswordSection> createState() => _NewPasswordSectionState();
}

class _NewPasswordSectionState extends State<NewPasswordSection>
    with LoadingOverlayMixin {
  OverlayEntry? _overlayEntry;
  void _removeLoadingOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;
    _overlayEntry = createOverlay();
    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  void dispose() {
    _removeLoadingOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userState = context.watch<RegisterUserCubit>().state;
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          _removeLoadingOverlay();
          const FinishRegisterRoute($extra: true).pushReplacement(context);
        }

        if (state is AuthLoading) {
          _showOverlay();
        }

        if (state is AuthError) {
          _removeLoadingOverlay();
        }
      },
      child: OnboardingMainSection(
        titleLabel: 'Ingresa tu nueva contraseña',
        onPressedFloatingActionButton: !userState.isPasswordMatched
            ? null
            : () {
                sl<AuthenticationBloc>().add(CreatePassword(
                  password: userState.password,
                  useBiometric: userState.useBiometric,
                ));
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
          const SizedBox(height: 22),
          const _Biametrics()
        ],
      ),
    );
  }
}

class _Biametrics extends StatelessWidget {
  const _Biametrics();

  @override
  Widget build(BuildContext context) {
    final userState = context.watch<RegisterUserCubit>().state;

    return BlocBuilder<BiometricDartCubit, BiometricDartState>(
      builder: (context, state) {
        if (state is BiometricUnavailable) {
          return Text(state.reason);
        }
        return Row(children: [
          Checkbox(
            value: userState.useBiometric,
            onChanged: (val) {
              context
                  .read<RegisterUserCubit>()
                  .updateUseBiometric(val ?? false);
            },
          ),
          const Flexible(
            child: Padding(
              padding: EdgeInsets.only(top: 12, right: 12),
              child: Text(
                  'Activar biometría del celular como segundo factor de seguridad (2FA)'),
            ),
          ),
        ]);
      },
    );
  }
}
