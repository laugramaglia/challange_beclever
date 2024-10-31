import 'package:challange_beclever/core/theme/extensions/theme_buttons_extension.dart';
import 'package:challange_beclever/core/theme/ui/custom_scaffold.dart';
import 'package:challange_beclever/core/utils/extensions/context.dart';
import 'package:challange_beclever/features/auth/presentation/ui/pages/register_sections/id_number_section.dart';
import 'package:challange_beclever/features/auth/presentation/ui/pages/register_sections/code_confirmation_section.dart';
import 'package:challange_beclever/features/auth/presentation/ui/pages/register_sections/mobile_section.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int _currentIndex = 2;

  List<Widget> _items(context) => [
        IdNumberSection(
            key: const ValueKey('id-number'), onChange: (value, error) {}),
        MobileSection(
            key: const ValueKey('mobile'), onChange: (value, error) {}),
        const CodeConfirmationSection(
          key: ValueKey('confirmation-code'),
        ),
      ];

  bool get _isFirstPage => _currentIndex == 0;
  void onPressedBAckButton() {
    if (_isFirstPage) {
      return;
    }
    setState(() {
      _currentIndex--;
    });
  }

  void onPressedNextButton() {
    if (_currentIndex == _items(context).length - 1) {
      return;
    }
    setState(() {
      _currentIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      titleLabel: 'Crear cuenta',
      leading: IconButton(
        icon: _isFirstPage
            ? const SizedBox.shrink()
            : Icon(Icons.arrow_back, color: context.colorScheme.onPrimary),
        onPressed: _isFirstPage ? null : onPressedBAckButton,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          height: 56,
          child: ElevatedButton(
            onPressed: onPressedNextButton,
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
              value: (_currentIndex + 1) / _items(context).length,
              borderRadius: BorderRadius.circular(20),
              minHeight: 8,
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: _items(context)[_currentIndex],
            ),
          ),
        ],
      ),
    );
  }
}
