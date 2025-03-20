import 'package:flutter/material.dart';
import 'package:the_salon/features/auth/presentation/pages/sign_in_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SignInPage());
  }
}
