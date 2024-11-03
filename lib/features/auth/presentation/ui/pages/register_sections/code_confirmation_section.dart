import 'package:challange_beclever/core/config/bloc/service_locator.dart';
import 'package:challange_beclever/core/config/router/routes.dart';
import 'package:challange_beclever/core/theme/mixins/loading_overlay_mixin.dart';
import 'package:challange_beclever/core/utils/extensions/context.dart';
import 'package:challange_beclever/features/auth/presentation/bloc/auth_bloc/authentication_bloc.dart';
import 'package:challange_beclever/features/auth/presentation/bloc/register_user/register_user_cubit.dart';
import 'package:challange_beclever/features/auth/presentation/bloc/stepper_index/stepper_index_cubit.dart';
import 'package:challange_beclever/features/auth/presentation/ui/widgets/onboarding_main_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CodeConfirmationSection extends StatefulWidget {
  const CodeConfirmationSection({super.key});

  @override
  State<CodeConfirmationSection> createState() =>
      _CodeConfirmationSectionState();
}

class _CodeConfirmationSectionState extends State<CodeConfirmationSection>
    with LoadingOverlayMixin {
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
    final userState = context.watch<RegisterUserCubit>().state;
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          _removeLoadingOverlay();
          context.read<RegisterUserCubit>().verifyNumber();
        }

        if (state is AuthLoading) {
          _showOverlay();
        }

        if (state is AuthError) {
          _removeLoadingOverlay();

          const FinishRegisterRoute($extra: false).push(context);
        }
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return OnboardingMainSection(
            key: const ValueKey('code-confirmation'),
            titleLabel: 'Ingresa el código',
            descriptionLabel:
                'El numero de cuatro digitos que enviamos al ${userState.pohneNumber}',
            onPressedFloatingActionButton: !userState.isNumberVerified
                ? null
                : context.read<StepperIndexCubit>().nextPage,
            secondaryButtonLabel: 'Cambiar Teléfono',
            secondaryOnPressed: context.read<StepperIndexCubit>().previousPage,
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
                onCompleted: (value) {
                  sl<AuthenticationBloc>().add(
                    VerifyPhone(
                      cedula: userState.idNumber,
                      phone: userState.pohneNumber,
                      code: value,
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Podras reenviar el codigo en 30s',
                    style: context.theme.textTheme.bodySmall),
              ),
              const SizedBox(height: 32),
              if (state is AuthError)
                Text(state.message,
                    style: context.theme.textTheme.bodySmall
                        ?.copyWith(color: context.colorScheme.error))
            ],
          );
        },
      ),
    );
  }
}
