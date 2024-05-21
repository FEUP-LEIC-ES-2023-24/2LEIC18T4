import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:study_at/pages/auth_page.dart';
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

  FirebaseAuth.instance.authStateChanges().listen((user) async {
    // Crie um nó de usuário no banco de dados Firebase Realtime Database
    final DatabaseReference userRef = FirebaseDatabase.instance.ref("users");
    final DatabaseReference placeRef = FirebaseDatabase.instance.ref("places");
    final DatabaseReference userPlaceRef =
        FirebaseDatabase.instance.ref("user-place");
    List<String> places = [];
    final String userEmail = user!.email!
        .replaceAll('.', '_')
        .replaceAll('@', '_')
        .replaceAll('#', '_');

    final DatabaseReference userNodeRef = userRef.child(userEmail);
    final DatabaseReference userPlaceNodeRef = userPlaceRef.child(userEmail);

    final DataSnapshot prazer = await userNodeRef.get();

    if (prazer.exists) return;

    placeRef.once().then((event) {
          DataSnapshot snapshot = event.snapshot;
          Map<dynamic, dynamic>? placeData =
              snapshot.value as Map<dynamic, dynamic>?;
          if (placeData != null) {
            placeData.forEach((key, value) {
              places.add(key);
            });
          }
    });
    print("adding user info");
    places.forEach(print);
    await userNodeRef.set({
      'name': user!.email!.split('@')[0],
      'username': user!.email!.split('@')[0],
      'bio': 'A new Study@ user!',
      'faculty': {'name': 'Other', 'color': Colors.black.value},
      'profileImage': "https://picsum.photos/seed/283/600",
      'admin': false,
    });

    places.forEach((place) async {
          DatabaseReference placeRef = userPlaceNodeRef.child(place);
          await placeRef.set({
            'comment': "",
            'favorite': false,
            'rating': 0,
            'reviewed': false,
            'visited': false
          });
    });
  });

  runApp(const StudyAt());
}

class StudyAt extends StatelessWidget {
  const StudyAt({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      theme:
          ThemeData(fontFamily: 'Merriweather', colorSchemeSeed: Colors.white),
    );
  }
}
