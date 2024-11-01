import 'package:challange_beclever/core/config/router/routes.dart';
import 'package:challange_beclever/core/theme/mixins/loading_overlay_mixin.dart';
import 'package:challange_beclever/core/utils/extensions/context.dart';
import 'package:challange_beclever/features/auth/data/models/validate_phone_req_params.dart';
import 'package:challange_beclever/features/auth/presentation/bloc/register_user/register_user_cubit.dart';
import 'package:challange_beclever/features/auth/presentation/bloc/stepper_index/stepper_index_cubit.dart';
import 'package:challange_beclever/features/auth/presentation/bloc/validate_phone/validate_phone_cubit.dart';
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
  @override
  Widget build(BuildContext context) {
    final userState = context.watch<RegisterUserCubit>().state;
    return BlocProvider(
      create: (_) => ValidatePhoneCubit(),
      child: BlocListener<ValidatePhoneCubit, ValidatePhoneState>(
        listener: (context, state) {
          if (state is PhoneValidationSuccess) {
            context.read<RegisterUserCubit>().verifyNumber();

            // I preffer to do this, automatically go to the next page
            //   context.read<StepperIndexCubit>().nextPage();
          }

          if (state is PhoneValidationError) {
            const FinishRegisterRoute($extra: false).push(context);
          }
        },
        child: BlocBuilder<ValidatePhoneCubit, ValidatePhoneState>(
          builder: (context, state) {
            return OnboardingMainSection(
              key: const ValueKey('code-confirmation'),
              titleLabel: 'Ingresa el código',
              descriptionLabel:
                  'El numero de cuatro digitos que enviamos al 15${userState.pohneNumber}',
              onPressedFloatingActionButton: !userState.isNumberVerified
                  ? null
                  : context.read<StepperIndexCubit>().nextPage,
              secondaryButtonLabel: 'Cambiar Teléfono',
              secondaryOnPressed: () {
                context.read<StepperIndexCubit>().previousPage();
              },
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
                    insetOverlay<void>(
                        context,
                        () => context.read<ValidatePhoneCubit>().validatePhone(
                              ValidatePhoneReqParams(
                                phoneNumber: userState.pohneNumber,
                                code: value,
                              ),
                            ));
                  },
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Podras reenviar el codigo en 30s',
                      style: context.theme.textTheme.bodySmall),
                ),
                const SizedBox(height: 32),
                if (state is PhoneValidationError)
                  Text(state.error,
                      style: context.theme.textTheme.bodySmall
                          ?.copyWith(color: context.colorScheme.error))
              ],
            );
          },
        ),
      ),
    );
  }
}
