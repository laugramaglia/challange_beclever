import 'package:challange_beclever/core/theme/extensions/theme_buttons_extension.dart';
import 'package:challange_beclever/core/utils/extensions/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LanderPage extends StatelessWidget {
  const LanderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const _FloatingButton(),
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                context.colorScheme.primaryContainer,
                context.colorScheme.primary
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          alignment: const Alignment(0, -.2),
          child: SvgPicture.asset('assets/svg/logo.svg',
              height: 140,
              colorFilter: ColorFilter.mode(
                  context.colorScheme.onPrimary, BlendMode.srcIn))),
    );
  }
}

class _FloatingButton extends StatelessWidget {
  const _FloatingButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: context.colorScheme.onPrimary,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20)
              .copyWith(top: 32, bottom: 46),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                  onPressed: () {},
                  style: context.theme.buttonOutline,
                  child: const Center(child: Text('Crear cuenta'))),
              const SizedBox(height: 18),
              ElevatedButton(
                  onPressed: () {},
                  style: context.theme.buttonFilled,
                  child: const Center(child: Text('Ingresar'))),
            ],
          ),
        ),
      ),
    );
  }
}
