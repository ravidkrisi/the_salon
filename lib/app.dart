import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_salon/core/theme/light_theme.dart';
import 'package:the_salon/core/utils/service_locator.dart';
import 'package:the_salon/features/auth/presentation/pages/auth_page.dart';
import 'package:the_salon/features/auth/presentation/pages/sign_up_page.dart';
import 'package:the_salon/features/home/presentation/pages/home_page.dart';
import 'package:the_salon/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:the_salon/features/auth/presentation/bloc/auth_state.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // AUTH BLOC
        BlocProvider(create: (context) => getIt<AuthBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'The Salon',
        theme: lightTheme,
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

            if (state is AuthFirstTimeUser) {
              return SignUpPage(
                userId: state.userId,
                name: state.name,
                email: state.email,
                phoneNumber: state.phoneNumber,
                profileImageUrl: state.profileImageUrl,
              );
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
              print(state.message);
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
