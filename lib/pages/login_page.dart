import 'package:flutter/material.dart';
import 'package:study_at/pages/auth_page.dart';
import 'package:study_at/pages/home_page_guest.dart';
import 'package:study_at/pages/user_login.dart';
import 'package:study_at/pages/user_register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 150),
              child: Text(
                'Welcome to Study@',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            TextButton(
              child: Text('Login', style: TextStyle(color: Colors.white)),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  textStyle: TextStyle(color: Colors.white)),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => AuthPage()))),
            ),
            const SizedBox(height: 20),
            TextButton(
              child: Text('Register', style: TextStyle(color: Colors.white)),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  textStyle: TextStyle(color: Colors.white)),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => UserRegister()))),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              ),
              child: const Text(
                'Continue as guest',
                style: TextStyle(fontSize: 15),
              ),
            ),
            const Spacer(),
            const Text(
              'Copyright © 2024 Study@. All Rights Reserved.',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 110,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'lib/images/porto.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
