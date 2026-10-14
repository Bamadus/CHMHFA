
import 'package:chmhfa_app/Views/states/authProvider.dart';
import 'package:chmhfa_app/Views/routes/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import your actual home screen
import 'package:chmhfa_app/Views/routes/home.dart';

class Auth_layout extends StatelessWidget {
  const Auth_layout({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    switch (authProvider.status) {

      // User is successfully logged in
      case AuthStatus.authenticated:
        return const Home();

      // User is not logged in
      case AuthStatus.unauthenticated:
        return const Login();

      // Checking login state or processing authentication
      case AuthStatus.loading:
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
    }
  }
}
