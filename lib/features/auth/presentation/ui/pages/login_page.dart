import 'dart:developer';

import 'package:challange_beclever/core/config/bloc/service_locator.dart';
import 'package:challange_beclever/core/config/router/routes.dart';
import 'package:challange_beclever/core/theme/mixins/loading_overlay_mixin.dart';
import 'package:challange_beclever/core/theme/ui/custom_scaffold.dart';
import 'package:challange_beclever/core/utils/extensions/context.dart';
import 'package:challange_beclever/features/auth/presentation/bloc/auth_bloc/authentication_bloc.dart';
import 'package:challange_beclever/features/auth/presentation/bloc/login_password/login_password_cubit.dart';
import 'package:challange_beclever/features/auth/presentation/ui/widgets/onboarding_main_section.dart';
import 'package:challange_beclever/features/auth/presentation/ui/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoadingOverlayMixin {
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    sl<AuthenticationBloc>().add(ResetState());
  }

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
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, authState) {
        if (authState is AuthSuccess) {
          _removeLoadingOverlay();
          const HomeRoute().go(context);
        }
        if (authState is AuthError) {
          _removeLoadingOverlay();
        }
        if (authState is AuthLoading) {
          _showOverlay();
        }
      },
      builder: (context, authState) {
        return CustomScaffold(
          titleLabel: 'Iniciar sesion',
          leading: const SizedBox.shrink(),
          body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 40),
            child: BlocProvider(
              create: (context) => LoginPasswordCubit(),
              child: BlocBuilder<LoginPasswordCubit, LoginPasswordState>(
                builder: (context, state) {
                  return OnboardingMainSection(
                      titleLabel: 'Ingresa tus datos',
                      onPressedFloatingActionButton: !state.hasCredentials
                          ? null
                          : () {
                              sl<AuthenticationBloc>().add(LoginPassword(
                                idNumber: state.idNumber,
                                password: state.password,
                              ));
                            },
                      secondaryButtonLabel: 'Crear cuenta',
                      secondaryOnPressed: () {
                        const RegisterRoute().go(context);
                      },
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
                          onChange: (value, error) {
                            log(state.toString());
                            if (error == null && value.isNotEmpty) {
                              context
                                  .read<LoginPasswordCubit>()
                                  .updateIdNumber(value);
                            } else if (state.idNumber.isNotEmpty) {
                              context
                                  .read<LoginPasswordCubit>()
                                  .updateIdNumber('');
                            }
                          },
                        ),
                        const SizedBox(height: 22),
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
                              context
                                  .read<LoginPasswordCubit>()
                                  .updatePassword(value);
                            } else if (state.password.isNotEmpty) {
                              context
                                  .read<LoginPasswordCubit>()
                                  .updatePassword('');
                            }
                          },
                        ),
                        if (authState is AuthError) ...[
                          const SizedBox(height: 22),
                          Text(
                            authState.message,
                            style: context.theme.textTheme.bodyMedium
                                ?.copyWith(color: context.colorScheme.error),
                          )
                        ]
                      ]);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
