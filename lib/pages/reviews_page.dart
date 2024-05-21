import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:study_at/components/store_imgdata.dart';
import 'package:study_at/debug_pages/create_bottom.dart';

class ReviewsPage extends StatefulWidget {
  final dynamic imagelink;
  final String name;
  final String id;

  const ReviewsPage(
      {super.key,
      required this.imagelink,
      required this.name,
      required this.id});
  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  /*late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }*/

  double _rating = 0;
  final TextEditingController reviewController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseDatabase.instance.ref('users');
  final DatabaseReference userPlaceCollection =
      FirebaseDatabase.instance.ref('user-place');
  late DatabaseReference userPlaceCurUser;
  late DatabaseReference userPlaceAllUsers;

  List<String> reviewedUsers = [];
  List<Map<String, dynamic>> reviews = [];

  @override
  void initState() {
    super.initState();
    userPlaceCurUser = userPlaceCollection
        .child(currentUser.email!
            .replaceAll('.', '_')
            .replaceAll('@', '_')
            .replaceAll('#', '_'))
        .child(widget.id);
    retrieveUserReviews();
    retrieveReviews(reviewedUsers);
  }

  void retrieveUserReviews() {
    userPlaceCollection.onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      List<String> userreviews = [];
      Map<dynamic, dynamic>? userPlaceData =
          snapshot.value as Map<dynamic, dynamic>?;

      if (userPlaceData != null) {
        userPlaceData.forEach((userId, userData) {
          userData.forEach((placeId, placeData) {
            if (placeId == widget.id && placeData['reviewed'] == true) {
              userreviews.add(userId);
            }
          });
        });
      }

      setState(() {
        reviewedUsers = userreviews;
      });
    });
  }

  void retrieveReviews(List<String> users) {

  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      /*onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),*/
      child: Scaffold(
        //key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
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
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                            child: Icon(
                              Icons.chat_bubble_rounded,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Text(
                            '${reviewedUsers.length} Reviews',
                            style: TextStyle(
                              fontSize: 20,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(35, 10, 25, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0, -1),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                                child: Icon(
                                  Icons.supervised_user_circle_rounded,
                                  color: Colors.black,
                                  size: 38,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: 206,
                                        height: 34,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFB0AA63),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(0),
                                            topLeft: Radius.circular(25),
                                            topRight: Radius.circular(0),
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  15, 5, 5, 0),
                                          child: Text(
                                            'TheEconomist said:',
                                            style: TextStyle(
                                              color: Colors.white,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 0, 0),
                                          child: Icon(
                                            Icons.star_rate,
                                            color: Colors.black,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Text(
                                          '2/5',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(-1, 0),
                                    child: AutoSizeText(
                                      'Its rough out there! Stay safe yall. FEP still on top!a',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 14,
                                        letterSpacing: 0,
                                      ),
                                      minFontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                child: Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 209,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Icon(
                                  Icons.rate_review_sharp,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                child: Text(
                                  'Post your own review',
                                  style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 0,
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
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Center(
                            child: Text("Review ${widget.name.toString()}")),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RatingBar.builder(
                                itemBuilder: (context, _) =>
                                    Icon(Icons.star, color: Colors.amber),
                                allowHalfRating: true,
                                onRatingUpdate: (rating) {
                                  setState(() {
                                    _rating = rating;
                                  });

                                  // test
                                }),
                            SizedBox(
                              height: 18,
                            ),
                            TextField(
                              controller: reviewController,
                              decoration: InputDecoration(
                                  labelText: "Write your review",
                                  hintText: "Your review goes here"),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white)),
                              onPressed: () {
                                userPlaceCurUser.update({
                                  'rating': _rating,
                                  'comment': reviewController.text,
                                  'reviewed': true
                                });
                                reviewController.clear();
                                // Debug
                                reviewedUsers.forEach(print);
                                Navigator.of(context).pop();
                              },
                              child: Text("Submit review"),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
