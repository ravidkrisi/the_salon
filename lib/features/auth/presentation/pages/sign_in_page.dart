import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_salon/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:the_salon/features/auth/presentation/bloc/auth_event.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: double.infinity),
        // logo
        Text('Welcome to'),
        Text(
          'The Salon',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        // sign in with google btn
        MaterialButton(
          onPressed: () {
            context.read<AuthBloc>().add(AuthSignInWithGoogle());
          },
          child: Text('sign in'),
        ),
      ],
    );
  }
}
