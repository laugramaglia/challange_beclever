import 'package:challange_beclever/core/theme/extensions/theme_buttons_extension.dart';
import 'package:challange_beclever/core/theme/ui/custom_scaffold.dart';
import 'package:challange_beclever/core/utils/extensions/context.dart';
import 'package:challange_beclever/features/auth/presentation/bloc/stepper_index/stepper_index_cubit.dart';
import 'package:challange_beclever/features/auth/presentation/ui/pages/register_sections/id_number_section.dart';
import 'package:challange_beclever/features/auth/presentation/ui/pages/register_sections/code_confirmation_section.dart';
import 'package:challange_beclever/features/auth/presentation/ui/pages/register_sections/mobile_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _Data(
      [
        IdNumberSection(
            key: const ValueKey('id-number'), onChange: (value, error) {}),
        MobileSection(
            key: const ValueKey('mobile'), onChange: (value, error) {}),
        const CodeConfirmationSection(
          key: ValueKey('confirmation-code'),
        ),
      ],
    );
  }
}

class _Data extends StatelessWidget {
  final List<Widget> sections;

  const _Data(this.sections);

  @override
  Widget build(BuildContext context) {
    final indexState = context.watch<StepperIndexCubit>();
    return CustomScaffold(
      titleLabel: 'Crear cuenta',
      leading: IconButton(
        icon: indexState.isFirstPage
            ? const SizedBox.shrink()
            : Icon(Icons.arrow_back, color: context.colorScheme.onPrimary),
        onPressed: indexState.isFirstPage ? null : indexState.previousPage,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          height: 56,
          child: ElevatedButton(
            onPressed: () => indexState.nextPage(sections.length),
            style: context.theme.buttonFilled,
            child: const Center(child: Text('Continuar')),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(40),
            child: LinearProgressIndicator(
              value: (indexState.state + 1) / sections.length,
              borderRadius: BorderRadius.circular(20),
              minHeight: 8,
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: sections[indexState.state],
            ),
          ),
        ],
      ),
    );
  }
}
