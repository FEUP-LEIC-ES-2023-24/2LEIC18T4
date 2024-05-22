import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:study_at/pages/place_page.dart';

/*class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}*/

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  /*late AchievementsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AchievementsPageModel());
  } */
  final currentUser = FirebaseAuth.instance.currentUser;
  final userPlaceCollection = FirebaseDatabase.instance.ref('user-place');
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref("places");
  late StreamSubscription<Position> positionStream;
  Color userColor = Colors.black;
  List<String> PlacesBoavista = [];
  List<String> PlacesCampoAlegre = [];
  List<String> PlacesAsprela = [];
  List<String> PlacesVilaDoConde = [];
  List<String> PlacesBatalha = [];
  List<String> PlacesFoz = [];
  List<String> PlacesCristal = [];
  List<String> visitedPlacesIds = [];

  Color colorConvert(int argbVal) {
    int red = (argbVal >> 16) & 0xFF;
    int green = (argbVal >> 8) & 0xFF;
    int blue = argbVal & 0xFF;

    return Color.fromRGBO(red, green, blue, 1.0);
  }

  void retrieveUserColor() {
    DatabaseReference userRef = FirebaseDatabase.instance.ref().child(
        "users/${currentUser?.email!.replaceAll('.', '_').replaceAll('@', '_').replaceAll('#', '_')}");

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

  @override
  void dispose() {
    positionStream.cancel();
    super.dispose();
  }

  void geolocationListener() {
    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream().listen((Position? position) {
      if (position != null) {
        medalUnlocker(position.latitude, position.longitude);
      }
    });
  }

  void medalUnlocker(double? lat, double? lon) async {
    if (lat != null && lon != null) {
      DataSnapshot snapshot = await databaseReference.get();
      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) async {
          double placelat = double.parse(value['latitude']);
          double placelon = double.parse(value['longitude']);
          if (Geolocator.distanceBetween(lat, lon, placelat, placelon) < 250) {
            await userPlaceCollection
                .child(FirebaseAuth.instance.currentUser!.email!
                    .replaceAll('.', '_')
                    .replaceAll('@', '_')
                    .replaceAll('#', '_'))
                .child(value['id'])
                .update({'visited': true});
          }
        });
      }
    }
  }
  void retrieveVisitedPlacesIds() {
    DatabaseReference userRef = FirebaseDatabase.instance.ref().child(
        "user-place/${currentUser?.email!.replaceAll('.', '_').replaceAll('@', '_').replaceAll('#', '_')}");

    userRef.onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      List<String> ids = [];
      Map<dynamic, dynamic>? userPlaceData =
          snapshot.value as Map<dynamic, dynamic>?;

      if (userPlaceData != null) {
        userPlaceData.forEach((placeId, placeData) {
          if (placeData['visited'] == true) {
            ids.add(placeId.toString());
          }
        });
      }

      setState(() {
        visitedPlacesIds = ids;
      });
    });
  }

  void retrievePlacesIds() {
    DatabaseReference userRef = FirebaseDatabase.instance.ref().child("places");

    userRef.onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      List<String> id1 = [];
      List<String> id2 = [];
      List<String> id3 = [];
      List<String> id4 = [];
      List<String> id5 = [];
      List<String> id6 = [];
      List<String> id7 = [];

      Map<dynamic, dynamic>? placeData =
          snapshot.value as Map<dynamic, dynamic>?;

      if (placeData != null) {
        placeData.forEach((placeId, placeData) {
          if (placeData['region'] == "Boavista") {
            id1.add(placeId.toString());
          }
          if (placeData['region'] == "Campo Alegre") {
            id2.add(placeId.toString());
          }
          if (placeData['region'] == "Asprela") {
            id3.add(placeId.toString());
          }
          if (placeData['region'] == "Vila do Conde") {
            id4.add(placeId.toString());
          }
          if (placeData['region'] == "Batalha") {
            id5.add(placeId.toString());
          }
          if (placeData['region'] == "Foz") {
            id6.add(placeId.toString());
          }
          if (placeData['region'] == "Palácio Cristal") {
            id7.add(placeId.toString());
          }
        });
      }

      setState(() {
        PlacesAsprela = id3;
        PlacesBatalha = id5;
        PlacesBoavista = id1;
        PlacesCampoAlegre = id2;
        PlacesCristal = id7;
        PlacesFoz = id6;
        PlacesVilaDoConde = id4;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    retrievePlacesIds();
    retrieveVisitedPlacesIds();
    retrieveUserColor();
    geolocationListener();
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser != null) {
      return GestureDetector(
        /*onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),*/
        child: Scaffold(
          //key: scaffoldKey,
          backgroundColor: Colors.white,
          body: SafeArea(
            top: true,
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 3.0, bottom: 1.0),
                        child: Text(
                          "Discover@",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 3.0, bottom: 1.0),
                        child: Text(
                          "Collect medals as you visit new places!",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 190,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-1, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                              child: Text(
                                'Asprela',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w900,
                                  color: userColor,
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: PlacesAsprela.isEmpty
                                ? Center(
                                    child: Text("No places in Asprela"),
                                  )
                                : StreamBuilder(
                                    stream: databaseReference.onValue,
                                    builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
                                      if (snapshot.hasData && snapshot.data != null && snapshot.data!.snapshot.value != null) {
                                        Map<dynamic, dynamic> data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                                        List<Widget> items = [];
                                        data.forEach((key, value) {
                                          // Check if the place is in PlacesAsprela
                                          if (PlacesAsprela.contains(key)) {
                                            items.add(
                                              GestureDetector(
                                                onTap: visitedPlacesIds.contains(key) ? () {
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
                                                }
                                                : null,
                                                child: Container(
                                                  margin: EdgeInsets.all(5), // Add some spacing between items
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        width: 120,
                                                        height: 120,
                                                        clipBehavior: Clip.antiAlias,
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(value['imageLink']),
                                                          ),
                                                        ),
                                                      ),
                                                      if (!visitedPlacesIds.contains(key))
                                                        Container(
                                                          width: 120,
                                                          height: 120,
                                                          decoration: BoxDecoration(
                                                            color: Colors.black.withOpacity(0.75), // Semi-transparent overlay
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.lock,
                                                              color: Colors.white,
                                                              size: 32,
                                                            ),
                                                          ),
                                                        ),
                                                      if (visitedPlacesIds.contains(key))
                                                        Positioned.fill(
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              border: Border.all(
                                                                color: userColor,
                                                                width: 2,
                                                              ),
                                                              shape: BoxShape.circle,
                                                              color: Colors.transparent, // Ensure the container itself is transparent
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        });
                                        return SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: items,
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Center(
                                          child: Text("Error loading places"),
                                        );
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  ),
                          )
                        ],
                      ),
                    ),

                    Container(
                      width: 100,
                      height: 190,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-1, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                              child: Text(
                                'Batalha',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w900,
                                  color: userColor,
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: PlacesBatalha.isEmpty
                                ? Center(
                                    child: Text("No places in Batalha"),
                                  )
                                : StreamBuilder(
                                    stream: databaseReference.onValue,
                                    builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
                                      if (snapshot.hasData && snapshot.data != null && snapshot.data!.snapshot.value != null) {
                                        Map<dynamic, dynamic> data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                                        List<Widget> items = [];
                                        data.forEach((key, value) {
                                          // Check if the place is in PlacesAsprela
                                          if (PlacesBatalha.contains(key)) {
                                            items.add(
                                              GestureDetector(
                                                onTap: visitedPlacesIds.contains(key) ? () {
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
                                                }
                                                : null,
                                                child: Container(
                                                  margin: EdgeInsets.all(5), // Add some spacing between items
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        width: 120,
                                                        height: 120,
                                                        clipBehavior: Clip.antiAlias,
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(value['imageLink']),
                                                          ),
                                                        ),
                                                      ),
                                                      if (!visitedPlacesIds.contains(key))
                                                        Container(
                                                          width: 120,
                                                          height: 120,
                                                          decoration: BoxDecoration(
                                                            color: Colors.black.withOpacity(0.75), // Semi-transparent overlay
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.lock,
                                                              color: Colors.white,
                                                              size: 32,
                                                            ),
                                                          ),
                                                        ),
                                                      if (visitedPlacesIds.contains(key))
                                                        Positioned.fill(
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              border: Border.all(
                                                                color: userColor,
                                                                width: 2,
                                                              ),
                                                              shape: BoxShape.circle,
                                                              color: Colors.transparent, // Ensure the container itself is transparent
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        });
                                        return SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: items,
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Center(
                                          child: Text("Error loading places"),
                                        );
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  ),
                          )
                        ],
                      ),
                    ),

                    Container(
                      width: 100,
                      height: 190,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-1, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                              child: Text(
                                'Boavista',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w900,
                                  color: userColor,
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: PlacesBoavista.isEmpty
                                ? Center(
                                    child: Text("No places in Boavista"),
                                  )
                                : StreamBuilder(
                                    stream: databaseReference.onValue,
                                    builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
                                      if (snapshot.hasData && snapshot.data != null && snapshot.data!.snapshot.value != null) {
                                        Map<dynamic, dynamic> data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                                        List<Widget> items = [];
                                        data.forEach((key, value) {
                                          // Check if the place is in PlacesAsprela
                                          if (PlacesBoavista.contains(key)) {
                                            items.add(
                                              GestureDetector(
                                                onTap: visitedPlacesIds.contains(key) ? () {
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
                                                }
                                                : null,
                                                child: Container(
                                                  margin: EdgeInsets.all(5), // Add some spacing between items
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        width: 120,
                                                        height: 120,
                                                        clipBehavior: Clip.antiAlias,
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(value['imageLink']),
                                                          ),
                                                        ),
                                                      ),
                                                      if (!visitedPlacesIds.contains(key))
                                                        Container(
                                                          width: 120,
                                                          height: 120,
                                                          decoration: BoxDecoration(
                                                            color: Colors.black.withOpacity(0.75), // Semi-transparent overlay
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.lock,
                                                              color: Colors.white,
                                                              size: 32,
                                                            ),
                                                          ),
                                                        ),
                                                      if (visitedPlacesIds.contains(key))
                                                        Positioned.fill(
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              border: Border.all(
                                                                color: userColor,
                                                                width: 2,
                                                              ),
                                                              shape: BoxShape.circle,
                                                              color: Colors.transparent, // Ensure the container itself is transparent
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        });
                                        return SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: items,
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Center(
                                          child: Text("Error loading places"),
                                        );
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  ),
                          )
                        ],
                      ),
                    ),

                    Container(
                      width: 100,
                      height: 190,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-1, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                              child: Text(
                                'Campo Alegre',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w900,
                                  color: userColor,
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: PlacesCampoAlegre.isEmpty
                                ? Center(
                                    child: Text("No places in Campo Alegre"),
                                  )
                                : StreamBuilder(
                                    stream: databaseReference.onValue,
                                    builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
                                      if (snapshot.hasData && snapshot.data != null && snapshot.data!.snapshot.value != null) {
                                        Map<dynamic, dynamic> data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                                        List<Widget> items = [];
                                        data.forEach((key, value) {
                                          // Check if the place is in PlacesAsprela
                                          if (PlacesCampoAlegre.contains(key)) {
                                            items.add(
                                              GestureDetector(
                                                onTap: visitedPlacesIds.contains(key) ? () {
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
                                                }
                                                : null,
                                                child: Container(
                                                  margin: EdgeInsets.all(5), // Add some spacing between items
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        width: 120,
                                                        height: 120,
                                                        clipBehavior: Clip.antiAlias,
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(value['imageLink']),
                                                          ),
                                                        ),
                                                      ),
                                                      if (!visitedPlacesIds.contains(key))
                                                        Container(
                                                          width: 120,
                                                          height: 120,
                                                          decoration: BoxDecoration(
                                                            color: Colors.black.withOpacity(0.75), // Semi-transparent overlay
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.lock,
                                                              color: Colors.white,
                                                              size: 32,
                                                            ),
                                                          ),
                                                        ),
                                                      if (visitedPlacesIds.contains(key))
                                                        Positioned.fill(
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              border: Border.all(
                                                                color: userColor,
                                                                width: 2,
                                                              ),
                                                              shape: BoxShape.circle,
                                                              color: Colors.transparent, // Ensure the container itself is transparent
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        });
                                        return SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: items,
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Center(
                                          child: Text("Error loading places"),
                                        );
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  ),
                          )
                        ],
                      ),
                    ),
                    
                    Container(
                      width: 100,
                      height: 190,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-1, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                              child: Text(
                                'Palácio de Cristal',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w900,
                                  color: userColor,
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: PlacesCristal.isEmpty
                                ? Center(
                                    child: Text("No places in Palácio de Cristal"),
                                  )
                                : StreamBuilder(
                                    stream: databaseReference.onValue,
                                    builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
                                      if (snapshot.hasData && snapshot.data != null && snapshot.data!.snapshot.value != null) {
                                        Map<dynamic, dynamic> data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                                        List<Widget> items = [];
                                        data.forEach((key, value) {
                                          // Check if the place is in PlacesAsprela
                                          if (PlacesCristal.contains(key)) {
                                            items.add(
                                              GestureDetector(
                                                onTap: visitedPlacesIds.contains(key) ? () {
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
                                                }
                                                : null,
                                                child: Container(
                                                  margin: EdgeInsets.all(5), // Add some spacing between items
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        width: 120,
                                                        height: 120,
                                                        clipBehavior: Clip.antiAlias,
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(value['imageLink']),
                                                          ),
                                                        ),
                                                      ),
                                                      if (!visitedPlacesIds.contains(key))
                                                        Container(
                                                          width: 120,
                                                          height: 120,
                                                          decoration: BoxDecoration(
                                                            color: Colors.black.withOpacity(0.75), // Semi-transparent overlay
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.lock,
                                                              color: Colors.white,
                                                              size: 32,
                                                            ),
                                                          ),
                                                        ),
                                                      if (visitedPlacesIds.contains(key))
                                                        Positioned.fill(
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              border: Border.all(
                                                                color: userColor,
                                                                width: 2,
                                                              ),
                                                              shape: BoxShape.circle,
                                                              color: Colors.transparent, // Ensure the container itself is transparent
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        });
                                        return SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: items,
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Center(
                                          child: Text("Error loading places"),
                                        );
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  ),
                          )
                        ],
                      ),
                    ),
                    
                    Container(
                      width: 100,
                      height: 190,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-1, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                              child: Text(
                                'Foz',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w900,
                                  color: userColor,
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: PlacesFoz.isEmpty
                                ? Center(
                                    child: Text("No places in Foz"),
                                  )
                                : StreamBuilder(
                                    stream: databaseReference.onValue,
                                    builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
                                      if (snapshot.hasData && snapshot.data != null && snapshot.data!.snapshot.value != null) {
                                        Map<dynamic, dynamic> data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                                        List<Widget> items = [];
                                        data.forEach((key, value) {
                                          // Check if the place is in PlacesAsprela
                                          if (PlacesFoz.contains(key)) {
                                            items.add(
                                              GestureDetector(
                                                onTap: visitedPlacesIds.contains(key) ? () {
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
                                                }
                                                : null,
                                                child: Container(
                                                  margin: EdgeInsets.all(5), // Add some spacing between items
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        width: 120,
                                                        height: 120,
                                                        clipBehavior: Clip.antiAlias,
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(value['imageLink']),
                                                          ),
                                                        ),
                                                      ),
                                                      if (!visitedPlacesIds.contains(key))
                                                        Container(
                                                          width: 120,
                                                          height: 120,
                                                          decoration: BoxDecoration(
                                                            color: Colors.black.withOpacity(0.75), // Semi-transparent overlay
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.lock,
                                                              color: Colors.white,
                                                              size: 32,
                                                            ),
                                                          ),
                                                        ),
                                                      if (visitedPlacesIds.contains(key))
                                                        Positioned.fill(
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              border: Border.all(
                                                                color: userColor,
                                                                width: 2,
                                                              ),
                                                              shape: BoxShape.circle,
                                                              color: Colors.transparent, // Ensure the container itself is transparent
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        });
                                        return SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: items,
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Center(
                                          child: Text("Error loading places"),
                                        );
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  ),
                          )
                        ],
                      ),
                    ),
                    
                    Container(
                      width: 100,
                      height: 190,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-1, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                              child: Text(
                                'Vila do Conde',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w900,
                                  color: userColor,
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: PlacesVilaDoConde.isEmpty
                                ? Center(
                                    child: Text("No places in Vila do Conde"),
                                  )
                                : StreamBuilder(
                                    stream: databaseReference.onValue,
                                    builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
                                      if (snapshot.hasData && snapshot.data != null && snapshot.data!.snapshot.value != null) {
                                        Map<dynamic, dynamic> data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                                        List<Widget> items = [];
                                        data.forEach((key, value) {
                                          // Check if the place is in PlacesAsprela
                                          if (PlacesVilaDoConde.contains(key)) {
                                            items.add(
                                              GestureDetector(
                                                onTap: visitedPlacesIds.contains(key) ? () {
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
                                                }
                                                : null,
                                                child: Container(
                                                  margin: EdgeInsets.all(5), // Add some spacing between items
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        width: 120,
                                                        height: 120,
                                                        clipBehavior: Clip.antiAlias,
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(value['imageLink']),
                                                          ),
                                                        ),
                                                      ),
                                                      if (!visitedPlacesIds.contains(key))
                                                        Container(
                                                          width: 120,
                                                          height: 120,
                                                          decoration: BoxDecoration(
                                                            color: Colors.black.withOpacity(0.75), // Semi-transparent overlay
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.lock,
                                                              color: Colors.white,
                                                              size: 32,
                                                            ),
                                                          ),
                                                        ),
                                                      if (visitedPlacesIds.contains(key))
                                                        Positioned.fill(
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              border: Border.all(
                                                                color: userColor,
                                                                width: 2,
                                                              ),
                                                              shape: BoxShape.circle,
                                                              color: Colors.transparent, // Ensure the container itself is transparent
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        });
                                        return SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: items,
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Center(
                                          child: Text("Error loading places"),
                                        );
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  ),
                          )
                        ],
                      ),
                    ),
                  ],
            ),
          ),
        ),
      ),
        )
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.white60,
        body: Center(
          child: Text("You must be logged in to access this page."),
        ),
      );
    }
  }
}
