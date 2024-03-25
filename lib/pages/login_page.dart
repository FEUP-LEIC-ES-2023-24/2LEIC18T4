import 'package:flutter/material.dart';
import 'package:study_at/pages/home_page_guest.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
              '2024 © All rights reserved.',
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
