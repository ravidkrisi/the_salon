import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_salon/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:the_salon/features/auth/presentation/bloc/auth_event.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),

          SizedBox(width: double.infinity),
          // logo
          SvgPicture.asset(
            'assets/icons/logo.svg',
            width: MediaQuery.of(context).size.width * 0.5,
          ),

          SizedBox(height: 20),

          // welcome text
          Text('Welcome to,'),
          Text(
            'THE SALON',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),

          Spacer(),
          Spacer(),

          // sign in with google btn
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                context.read<AuthBloc>().add(AuthSignInWithGoogle());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.google),
                  SizedBox(width: 10),
                  Text('Sign In With Google'),
                ],
              ),
            ),
          ),

          SizedBox(height: 50),
        ],
      ),
    );
  }
}
