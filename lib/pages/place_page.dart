import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:study_at/pages/reviews_page.dart';

import "package:google_nav_bar/google_nav_bar.dart";

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

class _PlacePageState extends State<PlacePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final databaseReference = FirebaseDatabase.instance.ref("places");
  late String placeId = '';
  bool isStarred = false;
  Color userColor = Colors.black;

  void retrievePlaceId() {
    String name = widget.name.toString();
    String imageLink = widget.imagelink.toString();

    databaseReference.onValue.listen((dynamic event) {
      DataSnapshot snapshot = event.snapshot;
      Map<dynamic, dynamic> placesData =
          snapshot.value as Map<dynamic, dynamic>;

      placesData.forEach((key, value) {
        if (value['name'] == name && value['imageLink'] == imageLink) {
          setState(() {
            placeId = key;
          });
          return; // Stop iterating once the place is found
        }
      });
    });
  }

  Color colorConvert(int argbVal) {
    int red = (argbVal >> 16) & 0xFF;
    int green = (argbVal >> 8) & 0xFF;
    int blue = argbVal & 0xFF;

    return Color.fromRGBO(red, green, blue, 1.0);
  }

  void retrieveUserColor() {
    DatabaseReference userRef = FirebaseDatabase.instance.ref().child(
        "users/${currentUser.email!.replaceAll('.', '_').replaceAll('@', '_').replaceAll('#', '_')}");

    userRef.onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      int i = 0;
      Map<dynamic, dynamic>? userData =
          snapshot.value as Map<dynamic, dynamic>?;

      if (userData != null) {
        i = userData['faculty']['color'];
      }

      setState(() {
        userColor = colorConvert(i);
      });
    });
  }

  void addStar() {
    final DatabaseReference userRef = FirebaseDatabase.instance
        .ref("user-place")
        .child(currentUser.email!
            .replaceAll('.', '_')
            .replaceAll('@', '_')
            .replaceAll('#', '_'))
        .child(placeId)
        .child("favorite");

    userRef.set(true);
  }

  void removeStar() {
    final DatabaseReference userRef = FirebaseDatabase.instance
        .ref("user-place")
        .child(currentUser.email!
            .replaceAll('.', '_')
            .replaceAll('@', '_')
            .replaceAll('#', '_'))
        .child(placeId)
        .child("favorite");

    userRef.set(false);
  }

  /*@override
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
  }*/
  @override
  void initState() {
    super.initState();
    // Call the function to check if the place is starred
    retrievePlaceId();
    retrieveUserColor();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        //key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: double.infinity,
                    height: 340,
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
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                    child: Container(
                      width: double.infinity,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Align(
                                    alignment: AlignmentDirectional(-1, 0),
                                    child: AutoSizeText(
                                      widget.name.toString(),
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 33,
                                        letterSpacing: 0,
                                      ),
                                      minFontSize: 20,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.favorite,
                                          color: userColor,
                                          size: 37,
                                        ),
                                        onPressed: addStar,
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.heart_broken,
                                          color: userColor,
                                          size: 37,
                                        ),
                                        onPressed: removeStar,
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5, 0, 0, 0),
                                        child: Icon(
                                          Icons.share,
                                          color: userColor,
                                          size: 35,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Icon(
                                        Icons.favorite,
                                        color: userColor,
                                        size: 21,
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Text(
                                        '4.95',
                                        style: TextStyle(
                                          fontSize: 21,
                                          letterSpacing: 0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: RichText(
                                    textScaler:
                                        MediaQuery.of(context).textScaler,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Nº',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '2',
                                          style: TextStyle(
                                            color: userColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' in your area',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          ),
                                        )
                                      ],
                                      style: TextStyle(
                                        letterSpacing: 0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                    child: Container(
                      width: double.infinity,
                      height: 51,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.5,
                            ),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.markerTags.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 100,
                                height: 93,
                                decoration: BoxDecoration(
                                  color: userColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Text(
                                    widget.markerTags[index].toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 98,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: userColor,
                                size: 33,
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 0, 0),
                                  child: Text(
                                    'Biblioteca da FEUP, R. Dr. Roberto Frias, 4200-465 Porto',
                                    style: TextStyle(
                                      fontSize: 18,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 57,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.lock_clock,
                                    color: userColor,
                                    size: 33,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        7, 0, 7, 0),
                                    child: RichText(
                                      textScaler:
                                          MediaQuery.of(context).textScaler,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '8h30',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '-',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '19h30',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                        style: TextStyle(
                                          letterSpacing: 0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  RichText(
                                    textScaler:
                                        MediaQuery.of(context).textScaler,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Mon',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '-',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Fri',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                      style: TextStyle(
                                        letterSpacing: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                child: Text(
                                  'Open',
                                  style: TextStyle(
                                    color: userColor,
                                    fontSize: 20,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 53,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.emoji_events_rounded,
                                color: userColor,
                                size: 33,
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      7, 0, 0, 0),
                                  child: RichText(
                                    textScaler:
                                        MediaQuery.of(context).textScaler,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Discover@ medal: ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Locked',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20,
                                          ),
                                        )
                                      ],
                                      style: TextStyle(
                                        letterSpacing: 0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReviewsPage(
                                          imagelink:
                                              widget.imagelink.toString(),
                                        )),
                              );
                            },
                            child: Container(
                              width: 133,
                              height: 46,
                              decoration: BoxDecoration(
                                color: userColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Text(
                                  'Reviews',
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                    fontSize: 19,
                                    letterSpacing: 0,
                                  ),
                                ),
                              ),
                            ),
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
      ),
    );
  }
}
