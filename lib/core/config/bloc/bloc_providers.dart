import 'package:challange_beclever/core/theme/beclever_app.dart';
import 'package:challange_beclever/features/auth/presentation/bloc/stepper_index/stepper_index_cubit.dart';
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
      ],
      child: const BecleverApp(),
    );
  }
}
