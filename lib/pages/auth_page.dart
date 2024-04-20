import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_at/pages/landing_page.dart';
import 'package:study_at/pages/login_page.dart';
import 'package:study_at/pages/user_login.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return LandingPage();
        } else {
          return UserLogin();
        }
      },
    ));
  }
}
