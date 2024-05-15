import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

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
          double placelat = value['latitude'];
          double placelon = value['longitude'];
          if (Geolocator.distanceBetween(lat, lon, placelat, placelon) < 500) {
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
void retrievePlacesIds() {
    DatabaseReference userRef = FirebaseDatabase.instance.ref().child(
        "place");

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
        PlacesBoavista = id1;
        PlacesCampoAlegre = id2;
        PlacesAsprela = id3;
        PlacesVilaDoConde = id4;
        PlacesBatalha = id5;
        PlacesFoz = id6;
        PlacesCristal = id7;
      });
    });
  }
  

  @override
  void initState() {
    super.initState();
    retrieveUserColor();
    retrievePlacesIds();
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
                            child: GridView(
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1,
                              ),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: [
                                PlacesBoavista.isEmpty
                                  ? Center(
                                    child: Text("No places in Boavista"),
                                  )
                                  : Expanded(
                                    child: StreamBuilder(
                                      stream: databaseReference.onValue,
                                      builder: (BuildContext context,AsyncSnapshot<dynamic> snapshot) {
                                        // Add a return statement at the end
                                      if (snapshot.hasData && snapshot.data != null) {
                                        Map<dynamic, dynamic> data =
                                        snapshot.data!.snapshot.value;
                                        List<Widget> items = [];
                                        data.forEach((key, value) {
                                        // Check if the place is starred
                                        if (PlacesBoavista.contains(key)) {
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
                                                  )
                                                );
                                                }
                                              )
                                            );
                                          }
                                        }
                                        );
                                      }
                                      return Container();
                                      }
                                    )
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
                            child: GridView(
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1,
                              ),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/67/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/629/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/268/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/452/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/874/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/530/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/36/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/811/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/522/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                            child: GridView(
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1,
                              ),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/67/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/629/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/268/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/452/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/874/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/530/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/36/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/811/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/522/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                            child: GridView(
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1,
                              ),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/67/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/629/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/268/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/452/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/874/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/530/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/36/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/811/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/522/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                            child: GridView(
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1,
                              ),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/67/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/629/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/268/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/452/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/874/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/530/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/36/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/811/600',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/522/600',
                                    fit: BoxFit.cover,
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
                  ],
          ),
        ),
            )
          )
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
