import 'package:challange_beclever/core/config/bloc/service_locator.dart';
import 'package:challange_beclever/core/theme/beclever_app.dart';
import 'package:challange_beclever/features/auth/presentation/bloc/auth_bloc/authentication_bloc.dart';
import 'package:challange_beclever/features/auth/presentation/bloc/biometric/biometric_dart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviders extends StatelessWidget {
  const BlocProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => sl<AuthenticationBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<BiometricDartCubit>()..checkBiometrics(),
        ),
      ],
      child: const BecleverApp(),
    );
  }
}
