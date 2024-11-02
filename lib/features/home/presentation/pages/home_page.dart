import 'package:challange_beclever/core/theme/extensions/theme_buttons_extension.dart';
import 'package:challange_beclever/core/utils/extensions/context.dart';
import 'package:challange_beclever/features/auth/presentation/bloc/auth_bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocSelector<AuthenticationBloc, AuthenticationState, AuthSuccess?>(
        selector: (state) => state is AuthSuccess ? state : null,
        builder: (context, state) {
          return Center(
            child: SizedBox(
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (state case final state?) ...[
                    Text('Id: ${state.user.id}'),
                    Text('Cedula: ${state.user.cedula}'),
                    Text('PhoneNumber: ${state.user.phoneNumber}'),
                  ],
                  ElevatedButton(
                      style: context.theme.buttonFilled,
                      onPressed: () {
                        context.read<AuthenticationBloc>().add(LogOut());
                      },
                      child: const Text('Log out')),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
