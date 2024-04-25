import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:study_at/pages/place_page.dart';

class StarredPage extends StatefulWidget {
  const StarredPage({Key? key}) : super(key: key);

  @override
  State<StarredPage> createState() => _StarredPageState();
}

class _StarredPageState extends State<StarredPage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final databaseReference = FirebaseDatabase.instance.ref().child("places");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Starred",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Star your favourite studying places!",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: StreamBuilder(
                  stream: databaseReference.onValue,
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      Map<dynamic, dynamic> data = snapshot.data!.snapshot.value;
                      List<Widget> items = [];

                      data.forEach((key, value) {
                        if (value['imageLink'].toString().contains('')) { // CHANGE THIS FOR THE REAL DB, ONLY SHOWS THE ONES WE WANT
                          items.add(
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlacePage(
                                      imagelink: value['imageLink'],
                                      name: value['name'],
                                      markerTags: value['tags'],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 150,
                                height: 150,
                                margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                  color: Colors.orangeAccent,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      value['imageLink'],
                                    ),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 4,
                                      color: Color(0x33000000),
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    color: Colors.orangeAccent,
                                    width: 2,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0, 0.5),
                                      child: Text(
                                        value['name'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0, 1),
                                      child: Icon(
                                        Icons.stars,
                                        color: Colors.orangeAccent,
                                        size: 32,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      });

                      return GridView.count(
                        crossAxisCount: 3, // Number of items per row
                        children: items,
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}