import 'package:challange_beclever/core/theme/beclever_app.dart';
import 'package:challange_beclever/features/auth/presentation/bloc/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviders extends StatelessWidget {
  const BlocProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StepperIndexCubit>(
          create: (context) => StepperIndexCubit(),
        ),
        BlocProvider<RegisterUserCubit>(
          create: (context) => RegisterUserCubit(),
        ),
      ],
      child: const BecleverApp(),
    );
  }
}
