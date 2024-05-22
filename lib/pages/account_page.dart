import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:study_at/components/faculty_flag.dart';
import 'package:study_at/pages/edit_profile.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final userCollection = FirebaseDatabase.instance.ref('users');
  final DatabaseReference userPlaceCollection =
      FirebaseDatabase.instance.ref('user-place');
  int medalCount = 0;
  List<Map<dynamic, dynamic>> placesReviewed = [];

  Color colorConvert(int argbVal) {
    int red = (argbVal >> 16) & 0xFF;
    int green = (argbVal >> 8) & 0xFF;
    int blue = argbVal & 0xFF;

    return Color.fromRGBO(red, green, blue, 1.0);
  }

  void retrieveMedalCount() {
    DatabaseReference userRef = FirebaseDatabase.instance
        .ref()
        .child("user-place")
        .child(currentUser!.email!
            .replaceAll('.', '_')
            .replaceAll('@', '_')
            .replaceAll('#', '_'));

    userRef.onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      Map<dynamic, dynamic>? placeData =
          snapshot.value as Map<dynamic, dynamic>?;
      if (placeData != null) {
        placeData.forEach((key, value) {
          if (value['visited'] == true) {
            medalCount++;
          }
        });
      }
    });
  }

  void retrieveReviews() async {
    userPlaceCollection.onValue.listen((event) async {
      DataSnapshot snapshot = event.snapshot;
      List<Map<dynamic, dynamic>> rev = [];
      Map<dynamic, dynamic>? userPlaceData =
          snapshot.value as Map<dynamic, dynamic>?;

      if (userPlaceData != null) {
        String user = currentUser!.email!
            .replaceAll('.', '_')
            .replaceAll('@', '_')
            .replaceAll('#', '_');

        if (userPlaceData.containsKey(user)) {
          Map<dynamic, dynamic>? userReviews =
              userPlaceData[user] as Map<dynamic, dynamic>?;
          if (userReviews != null) {
            for (var entry in userReviews.entries) {
              await userCollection.child(user).get().then((snapshot2) {
                Map<dynamic, dynamic>? userData =
                    snapshot2.value as Map<dynamic, dynamic>?;

                if (userData != null) {
                  entry.value['username'] = userData['username'];
                  entry.value['image'] = userData['profileImage'];
                  entry.value['color'] = userData['faculty']['color'];
                }
              });
              // debugging
              // print(entry.value);
              rev.add(entry.value as Map<dynamic, dynamic>);
            }
          }
        }
      } else {
        print("nulled");
      }

      setState(() {
        placesReviewed = rev;
      });
    });
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    super.initState();
    if (currentUser != null) {
    retrieveMedalCount();
    retrieveReviews();
    }

  }

  @override
  Widget build(BuildContext context) {
    if (currentUser != null) {
      return StreamBuilder<DatabaseEvent>(
        stream: FirebaseDatabase.instance
            .ref()
            .child("users")
            .child(currentUser!.email!
                .replaceAll('.', '_')
                .replaceAll('@', '_')
                .replaceAll('#', '_'))
            .onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData =
                snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
            return GestureDetector(
              child: Scaffold(
                backgroundColor: Colors.white,
                body: SafeArea(
                  top: true,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, bottom: 1.0),
                          child: Text(
                            "Account",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 755,
                          height: 203,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    Positioned(
                                      child: Container(
                                        width: 120,
                                        height: 120,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.network(
                                          userData['profileImage'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: -2,
                                      left: 0,
                                      right: 0,
                                      child: Center(
                                        child: FacultyFlag(
                                          facultyName: userData['faculty']
                                              ['name'],
                                          facultyColor: colorConvert(
                                              userData['faculty']['color']),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12, 12, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 12),
                                            child: AutoSizeText(
                                              userData['name'],
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 25,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              minFontSize: 20,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 12),
                                            child: AutoSizeText(
                                              "@${userData['username']}",
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 16,
                                                letterSpacing: 0,
                                              ),
                                              minFontSize: 14,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 12),
                                            child: AutoSizeText(
                                              userData['bio'],
                                              textAlign: TextAlign.start,
                                              maxLines: 4,
                                              style: TextStyle(
                                                fontSize: 18,
                                                letterSpacing: 0,
                                              ),
                                              minFontSize: 12,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditProfile(),
                                            ),
                                          ),
                                          child: Text(
                                            'Edit Profile',
                                            style: TextStyle(
                                              color: colorConvert(
                                                  userData['faculty']['color']),
                                              fontSize: 18,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w900,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: 715,
                          height: 343,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(-1, 0),
                                          child: Text(
                                            'History',
                                            style: TextStyle(
                                              letterSpacing: 0,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: double.infinity,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(0),
                                          ),
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.network(
                                                  'https://picsum.photos/seed/771/600',
                                                  width: double.infinity,
                                                  height: 200,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Opacity(
                                                opacity: 0.4,
                                                child: Container(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    AlignmentDirectional(0, 0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(13, 13, 13, 13),
                                                   child: AutoSizeText(
                                                      placesReviewed[0]['comment'].isEmpty
                                                        ? "A review will come soon..."
                                                        : "'${placesReviewed[0]['comment']}'",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 24,
                                                      letterSpacing: 0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                    ),
                                                    minFontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 15,
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: double.infinity,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.network(
                                                  'https://picsum.photos/seed/592/600',
                                                  width: double.infinity,
                                                  height: 200,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Opacity(
                                                opacity: 0.4,
                                                child: Container(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    AlignmentDirectional(0, 0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(13, 13, 13, 13),
                                                  child: AutoSizeText(
                                                      placesReviewed[1]['comment'].isEmpty
                                                        ? "A review will come soon..."
                                                        : "'${placesReviewed[1]['comment']}'",

                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 24,
                                                      letterSpacing: 0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                    ),
                                                    minFontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
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
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Container(
                            width: 461,
                            height: 95,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0, -1),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15, 0, 15, 0),
                                child: Container(
                                  width: 432,
                                  height: 87,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Text(
                                            medalCount.toString(),
                                            style: TextStyle(
                                              color: colorConvert(
                                                  userData['faculty']['color']),
                                              fontSize: 45,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: RichText(
                                          textScaler:
                                              MediaQuery.of(context).textScaler,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Discover@',
                                                style: TextStyle(
                                                  color: colorConvert(
                                                      userData['faculty']
                                                          ['color']),
                                                  fontSize: 20,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' medals collected!',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20,
                                                ),
                                              )
                                            ],
                                            style: TextStyle(
                                              fontSize: 19,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: signUserOut, child: Text("Sign out")),
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error${snapshot.error}"),
            );
          }

          return Center(child: const CircularProgressIndicator());
        },
      );
    } else {
      return Scaffold(
          backgroundColor: Colors.white60,
          body: Center(
            child: Text("You must be logged in to access this page."),
          ));
    }
  }
}
