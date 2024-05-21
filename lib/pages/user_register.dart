import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:study_at/auth_service.dart';
import 'package:study_at/components/apptextfield.dart';
import 'package:study_at/components/icon_square_tile.dart';
import 'package:study_at/components/screens_button.dart';
import 'package:study_at/pages/landing_page.dart';

class UserRegister extends StatefulWidget {
  UserRegister({Key? key});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final usernamecontroller = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      if (passwordController.text == confirmPasswordController.text) {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: usernamecontroller.text,
                password: passwordController.text);

        // Crie um nó de usuário no banco de dados Firebase Realtime Database
        final DatabaseReference userRef =
            FirebaseDatabase.instance.ref("users");

        final DatabaseReference placeRef =
            FirebaseDatabase.instance.ref("places");

        List<String> places = [];

        final DatabaseReference userPlaceRef =
            FirebaseDatabase.instance.ref("user-place");

        final String userEmail = userCredential.user!.email!
            .replaceAll('.', '_')
            .replaceAll('@', '_')
            .replaceAll('#', '_');
        final DatabaseReference userNodeRef = userRef.child(userEmail);
        final DatabaseReference userPlaceNodeRef =
            userPlaceRef.child(userEmail);

        userNodeRef.set({
          'name': usernamecontroller.text.split('@')[0],
          'username': usernamecontroller.text.split('@')[0],
          'bio': 'A new Study@ user!',
          'faculty': {'name': 'Other', 'color': Colors.black.value},
          'profileImage': "https://picsum.photos/seed/283/600",
          'admin': false,
        }).then((_) {
          print('Nó do usuário criado com sucesso');
        }).catchError((error) {
          print('Falha ao criar nó do usuário: $error');
        });

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

        places.forEach((place) {
          DatabaseReference placeRef = userPlaceNodeRef.child(place);
          placeRef.set({
            'comment': "",
            'favorite': false,
            'rating': 0,
            'reviewed': false,
            'visited': false
          });
        });

        Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LandingPage()));
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        wrongEmail(context);
      } else if (e.code == 'wrong-password') {
        wrongPassword(context);
      }
    }
  }

  void wrongEmail(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(title: Text("Wrong or unregistered email."));
        });
  }

  void wrongPassword(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(title: Text("Incorrect password."));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Text(
                  "Study@",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 35),
                ),
                const SizedBox(height: 50),
                AppTextField(
                  controller: usernamecontroller,
                  hintText: "Email",
                  obscureText: false,
                ),
                const SizedBox(
                  height: 30,
                ),
                AppTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                AppTextField(
                  controller: confirmPasswordController,
                  hintText: "Confirm password",
                  obscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                ScreensButton(
                  buttonText: 'Register',
                  textColor: Colors.white,
                  buttonColor: Colors.black,
                  onTap: signUserUp,
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                              thickness: 0.5, color: Colors.grey.shade400)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text("Or continue with"),
                      ),
                      Expanded(
                          child: Divider(
                              thickness: 0.5, color: Colors.grey.shade400)),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconSquareTile(
                        onTap: () async {
                          await AuthService().signInGoogle();
                        },
                        imagepath: 'lib/images/google.png'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
