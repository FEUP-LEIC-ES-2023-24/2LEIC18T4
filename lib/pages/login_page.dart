import 'package:flutter/material.dart';
import 'package:study_at/pages/home_page_guest.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      const Flexible(
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Text(
                            'Welcome to Study@',
                            style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 30),
                            textAlign: TextAlign.center,
                            )
                          ),
                        ),


                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          )
                        ),
                          child: const Center(
                            child: Text('Continue as guest',
                            style: TextStyle(fontSize: 15))
                          )
                        ),

                      const Flexible(
                        child: Align(
                          alignment: AlignmentDirectional(0, 1.5),
                          child: Text(
                            '2024 © All rights reserved.',
                            style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 15),
                            textAlign: TextAlign.center,
                            ),
                          ),
                      ),

                      Flexible(
                        child: Align(
                          alignment: const AlignmentDirectional(0, 1),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'lib/images/porto.png',
                              height: 110,
                              fit: BoxFit.cover,
                              alignment: const Alignment(0, 0),
                            ),
                          ),
                        ),
                      ),
                    ]
                )
            )
        )
    );
  }
}
