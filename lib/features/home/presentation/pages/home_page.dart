import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_salon/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:the_salon/features/auth/presentation/bloc/auth_event.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => context.read<AuthBloc>().add(AuthLogout()),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(child: Text('home')),
    );
  }
}
