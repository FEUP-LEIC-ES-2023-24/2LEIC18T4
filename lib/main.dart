import 'package:flutter/material.dart';
import 'package:study_at/pages/login_page.dart';



void main() {
  runApp(const StudyAt());
}

class StudyAt extends StatelessWidget {
  const StudyAt({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      theme: ThemeData(fontFamily: 'Merriweather'),
    );
  }
}
