import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';

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
  final databaseReference =
      FirebaseDatabase.instance.ref().child("places");

  Color colorConvert(int argbVal) {
    int red = (argbVal >> 16) & 0xFF;
    int green = (argbVal >> 8) & 0xFF;
    int blue = argbVal & 0xFF;

    return Color.fromRGBO(red, green, blue, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      body: SafeArea(
        top: true,
        child:
        StreamBuilder(
          stream: databaseReference.onValue,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              Map<dynamic, dynamic> data = snapshot.data!.snapshot.value;
              List<Widget> items = [];
              int counter = 0;
              List<Widget> rowChildren = [];

              data.forEach((key, value) {
                if (value['imageLink'].toString().contains('')) { //CHANGE THIS FOR THE REAL DB, ONLY SHOWS THE ONES WE WANT
                  rowChildren.add(
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
                      child: Expanded(
                        child: Container( //CHANGE THESE TO CHANGE BOX SIZE
                          width: 150,
                          height: 150,
                          margin: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
                          child: Column(
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
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
                                      offset: Offset(
                                        0,
                                        2,
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    color: Colors.redAccent,
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
                                        Icons.stars_outlined,
                                        color: Colors.black,
                                        size: 24,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                  counter++;

                  if (counter == 3) { //CHANGE THIS VALUE TO GET MORE SQUARES PER ROW
                    items.add(Row(children: rowChildren));
                    rowChildren = [];
                    counter = 0;
                  }
                }
              });

              if (rowChildren.isNotEmpty) {
                items.add(Row(children: rowChildren));
              }

              if (items.isNotEmpty) {
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) => items[index],
                );
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
