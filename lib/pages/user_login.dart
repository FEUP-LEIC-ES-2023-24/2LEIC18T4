import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_at/components/apptextfield.dart';
import 'package:study_at/components/icon_square_tile.dart';
import 'package:study_at/components/screens_button.dart';
import 'package:typewritertext/typewritertext.dart';

class UserLogin extends StatefulWidget {
  UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final usernamecontroller = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usernamecontroller.text, password: passwordController.text);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        // print("wongemail");
        wrongEmail(context);
      } else if (e.code == 'wrong-password') {
        // print("wrongpass");
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
                  const SizedBox(height: 80),
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
                    height: 20,
                  ),
                  Text("Forgot your password?",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade500)),
                  const SizedBox(
                    height: 15,
                  ),
                  ScreensButton(
                    buttonText: 'Sign in',
                    textColor: Colors.white,
                    buttonColor: Colors.black,
                    onTap: signUserIn,
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
                          onTap:(){},
                          imagepath: 'lib/images/google.png'),
                      const SizedBox(
                        width: 40,
                      ),
                      IconSquareTile(
                          onTap:(){},
                          imagepath: 'lib/images/github.png'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
