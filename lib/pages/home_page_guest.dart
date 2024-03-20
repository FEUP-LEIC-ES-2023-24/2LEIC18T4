import 'package:flutter/material.dart';
import 'package:study_at/pages/login_page.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: screenSize.width * 0.25,
                height: screenSize.height * 0.55,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Card(
                    color: Colors.black,
                    elevation: 15, // Adiciona sombra ao Card
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Ajusta a curvatura das bordas
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
                          const SizedBox(height: 10), // Espaçamento entre os parágrafos
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
                                  // pagina depois do yes
                                },
                                child: const Text('Yes'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const LoginPage()),
                                  );
                                },
                                child: const Text('No'),
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
          ],
        ),
      ),
    );
  }
}