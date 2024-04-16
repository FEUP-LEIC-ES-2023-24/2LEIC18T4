import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class PlacePage extends StatefulWidget {
  final dynamic imagelink;
  final dynamic name;
  final List<dynamic> markerTags;
  const PlacePage(
      {super.key,
      required this.imagelink,
      required this.name,
      required this.markerTags});

  @override
  State<PlacePage> createState() => _PlacePageState();
}

final databaseReference = FirebaseDatabase.instance.ref("places");

class _PlacePageState extends State<PlacePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
                height: 250,
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.imagelink),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                )),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, bottom: 1.0, top: 25.0),
                child: Text(
                  widget.name.toString(),
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 1.0, top: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tags:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10), // Add some space between "Tags:" and the list of tags
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.markerTags.length,
                      itemBuilder: (context, index) {
                        return Text(
                          widget.markerTags[index].toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

          ],
        ));
  }
}
