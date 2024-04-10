import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:study_at/pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: 'AIzaSyBIdFDn75aSB6zm6LiRKxZ0k9ZCyr8j5ho',
    appId: '1:206182314858:android:a9e8effc89c2801675ab13',
    databaseURL:
        'https://studyatapp-default-rtdb.europe-west1.firebasedatabase.app',
    messagingSenderId: '206182314858',
    projectId: 'studyatapp',
    storageBucket: 'studyatapp.appspot.com',
  ));
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
