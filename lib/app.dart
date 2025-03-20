import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_salon/features/auth/data/firebase_auth_repo.dart';
import 'package:the_salon/features/auth/presentation/pages/auth_page.dart';
import 'package:the_salon/features/home/presentation/pages/home_page.dart';
import 'package:the_salon/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:the_salon/features/auth/presentation/bloc/auth_state.dart';

class MyApp extends StatelessWidget {
  // auth firebase repo
  final firebaseAuthRepo = FirebaseAuthRepo();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // AUTH BLOC
        BlocProvider(create: (context) => AuthBloc(repo: firebaseAuthRepo)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'The Salon',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: BlocConsumer<AuthBloc, AuthState>(
          builder: (context, state) {
            // loading
            if (state is AuthLoading) {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            }

            // authenticated
            if (state is AuthAuthenticated) {
              return HomePage();
            }

            // unauthenticated
            if (state is AuthUnauthenticated) {
              return AuthPage();
            }

            // default
            return Container();
          },
          listener: (context, state) {
            print(state);
            // errors
            if (state is AuthErrors) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
      ),
    );
  }
}
