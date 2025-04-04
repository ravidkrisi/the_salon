import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_salon/core/extensions/buildcontext.dart';
import 'package:the_salon/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:the_salon/features/auth/presentation/bloc/auth_event.dart';
import 'package:the_salon/features/auth/presentation/components/my_text_field.dart';

class SignUpPage extends StatefulWidget {
  final String userId;
  final String name;
  final String email;
  final String phoneNumber;
  final String profileImageUrl;
  const SignUpPage({
    super.key,
    required this.userId,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profileImageUrl,
  });

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // text controllers
  late final TextEditingController nameTextController;
  late final TextEditingController emailTextController;
  late final TextEditingController phoneTextController;

  @override
  void initState() {
    super.initState();
    setControllers();
  }

  void setControllers() {
    nameTextController = TextEditingController(text: widget.name);
    emailTextController = TextEditingController(text: widget.email);
    phoneTextController = TextEditingController(text: widget.phoneNumber);
  }

  @override
  void dispose() {
    // dispose controllers
    nameTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // name text field
            MyTextField(
              label: 'Name',
              hintText: 'Jhon Doe',
              controller: nameTextController,
            ),

            // email text field
            MyTextField(
              label: 'Email',
              hintText: 'Jhon@example.com',
              controller: emailTextController,
            ),

            // phone number text field
            MyTextField(
              label: 'Phone Number',
              hintText: '+972536331210',
              controller: phoneTextController,
              keyboardType: TextInputType.phone,
              formatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(13),
              ],
            ),

            // submit btn
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.colorScheme.primary,
                      foregroundColor: context.colorScheme.onPrimary,
                    ),
                    onPressed: () {
                      context.read<AuthBloc>().add(
                        AuthSignUpUser(
                          userId: widget.userId,
                          email: emailTextController.text,
                          name: nameTextController.text,
                          phoneNumber: phoneTextController.text,
                          profileImageUrl: widget.profileImageUrl,
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Done',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Icon(Icons.chevron_right, size: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
