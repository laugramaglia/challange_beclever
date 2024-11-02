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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state case final state?) ...[
                  Text('Id: ${state.user.id}'),
                  Text('PhoneNumber: ${state.user.phoneNumber}'),
                ],
                ElevatedButton(
                    onPressed: () {
                      context.read<AuthenticationBloc>().add(LogOut());
                    },
                    child: const Text('logOut')),
              ],
            ),
          );
        },
      ),
    );
  }
}
