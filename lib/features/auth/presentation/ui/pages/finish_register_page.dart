import 'package:challange_beclever/core/config/router/routes.dart';
import 'package:challange_beclever/features/auth/presentation/ui/widgets/continue_button.dart';
import 'package:flutter/material.dart';
import 'package:challange_beclever/core/utils/extensions/context.dart';
import 'dart:math' as math;

class FinishRegisterPage extends StatelessWidget {
  final bool isSuccess;
  const FinishRegisterPage({super.key, required this.isSuccess});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.onPrimary,
      body: Stack(children: [
        Positioned.fill(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.rotate(
                  angle: 15 * math.pi / 180,
                  child: Image.asset(
                    'assets/png/phone.png',
                    height: 300,
                  ),
                ),
                Text(
                  isSuccess ? 'Excelente!' : 'Ups!',
                  style: context.theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isSuccess ? null : context.colorScheme.error),
                ),
                const SizedBox(height: 12),
                Text(
                  isSuccess
                      ? 'Ya creaste tu usuario y contraseña.'
                      : 'No pudimos verificar tu telefono.',
                  style: context.theme.textTheme.bodyLarge,
                ),
              ]),
        ),
        Positioned(
          bottom: 32,
          right: 32,
          left: 32,
          child: Continuebutton(
            onPressed: () {
              if (isSuccess) {
                const HomeRoute().go(context);
                return;
              }
              const LanderRoute().go(context);
            },
            label: isSuccess ? 'Continuar' : 'Volver a intentar',
          ),
        ),
        Align(
          alignment: const Alignment(-.2, -.34),
          child: _ToIconTransition(isSuccess),
        ),
      ]),
    );
  }
}

class _ToIconTransition extends StatelessWidget {
  final bool isSuccess;
  const _ToIconTransition(this.isSuccess);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 30, end: 1),
      duration: const Duration(milliseconds: 800),
      curve: const Interval(0.4, 1, curve: Curves.fastOutSlowIn),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: CircleAvatar(
        radius: 45,
        backgroundColor: isSuccess ? Colors.green : context.colorScheme.error,
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(milliseconds: 800),
          curve: const Interval(0.8, 1, curve: Curves.fastOutSlowIn),
          builder: (context, double value, child) =>
              Opacity(opacity: value, child: child),
          child: Icon(
            isSuccess ? Icons.check : Icons.close,
            color: isSuccess ? Colors.white : context.colorScheme.onError,
            size: 50,
          ),
        ),
      ),
    );
  }
}
