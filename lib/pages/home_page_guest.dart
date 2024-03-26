import 'package:flutter/material.dart';
import 'package:study_at/pages/landing_page.dart';
import 'package:study_at/pages/login_page.dart';
import 'package:study_at/pages/map.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: screenSize.width * 0.60,
                height: screenSize.height * 0.50,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Card(
                    color: Colors.black,
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'By proceeding as a guest, you will lose most of the app’s features.',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const Text(
                            'Are you sure you want to continue as a guest?',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        // TESTING - DEBUG
                                        builder: (context) => LandingPage()),
                                  );
                                },
                                child: const Text('Yes',
                                    style: TextStyle(
                                      color: Color.fromRGBO(140, 45, 25, 1.0),
                                    )),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()),
                                  );
                                },
                                child: const Text('No',
                                    style: TextStyle(
                                      color: Color.fromRGBO(140, 45, 25, 1.0),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Flexible(
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Text(
                  'Copyright © 2024 Study@. All Rights Reserved.',
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 10),
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
          ],
        ),
      ),
    );
  }
}
