import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:study_at/components/apptextfield.dart';
import 'package:study_at/components/icon_square_tile.dart';
import 'package:study_at/components/screens_button.dart';
import 'package:study_at/pages/landing_page.dart';
import 'package:typewritertext/typewritertext.dart';

class UserRegister extends StatefulWidget {
  UserRegister({super.key});

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

        final DatabaseReference userRef = FirebaseDatabase.instance.ref("users");
        // Sanitized email...
        final String userEmail = userCredential.user!.email!.replaceAll('.', '_').replaceAll('@', '_').replaceAll('#', '_');
        final DatabaseReference userNodeRef = userRef.child(userEmail);

        userNodeRef.set({
          'name': usernamecontroller.text.split('@')[0],
          'username': usernamecontroller.text.split('@')[0],
          'bio': 'A new Study@ user!',
          'faculty': ['Other', 'Colors.black']
        }).then((_) {
          print('User node created successfully');
        }).catchError((error) {
          print('Failed to create user node: $error');
        });


        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: usernamecontroller.text, password: passwordController.text);
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
          return const AlertDialog(
              title: Text("Incorrect or not registered email."));
        });
  }

  void wrongPassword(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
              title: Text("Incorrect password. Try again or reset it."));
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
                  /*
                  // Overflows....
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: 20.0),
                    width: MediaQuery.of(context).size.width,
                    child: TypeWriterText(
                      text: Text('Asprela', style: TextStyle(fontSize: 20),),
                      duration: Duration(milliseconds: 100),
                    )
                  ),
                  */
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
                    buttonText: 'Sign up',
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
                      IconSquareTile(imagepath: 'lib/images/google.png'),
                      const SizedBox(
                        width: 40,
                      ),
                      IconSquareTile(imagepath: 'lib/images/github.png'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
