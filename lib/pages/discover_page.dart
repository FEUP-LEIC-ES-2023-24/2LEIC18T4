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
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://lh3.googleusercontent.com/proxy/vZdtAqQBb3WCFntjm3TNW_dz8Vh_ko1isJyWqlNPjbUqKAzbEwA8d1kn5wncKMIDHspiZnUypgbIp0LRkoh1LEfRMIjgQ50REafUCnorprX7iq5Gv2Ocx4W3T-LLgx0-RA',
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
                                    'https://convida.pt/images/POIs/CafeCasaMusica-Convida-2017-010.jpg',
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
                                    'https://assets.savills.com/properties/PTOPO1LIS002166L/1_2166_114371_l_gal.jpg',
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
                                    'https://noticias.up.pt/wp-content/uploads/2023/06/estudantes-jardins-ciencias.jpg',
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
                                    'https://oliviahouses.com/wp-content/uploads/2023/06/jardim-botanico-porto-olivia.webp',
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
                                    'https://noticias.up.pt/wp-content/uploads/2023/06/jardins-faup_02.jpg',
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
                                    'https://laptopfriendly.co/images/places/porto/e-learning-cafe-u-porto/e-learning-cafe-u-porto%20porto%20e-learning-cafe-u-porto-porto%20.jpg',
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
                                    'https://sigarra.up.pt/up/pt/imagens/album/n329',
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
                                    'https://mapio.net/images-p/37718994.jpg',
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
                                    'https://ler.letras.up.pt/uploads/ficheiros/18955.JPG',
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
                                    'http://h5p.org/sites/default/files/h5p/content/292659/images/image-5b6c21bd54857.jpg',
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
                                    'https://noticias.up.pt/wp-content/uploads/2022/03/parque-central-da-asprela-pre.inauguracao_04.jpg',
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
                                    'https://laptopfriendly.co/images/places/porto/e-learning-cafe-u-porto/e-learning-cafe-u-porto%20porto%20e-learning-cafe-u-porto-porto%20.jpg',
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
                                    'https://biblioteca.med.up.pt/wp-content/uploads/2017/04/1-1024x397.jpg',
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
                                    'https://omega.com.pt/wp-content/uploads/2016/11/%C2%A9Telmo-Miller-8181-copy.jpg',
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
                                    'https://noticias.up.pt/wp-content/uploads/2023/06/estudantes-jardins-fbaup.jpg',
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
                                    'https://upload.wikimedia.org/wikipedia/commons/4/4a/Biblioteca_Municipal_Porto-01.jpg',
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
                                    'https://live.staticflickr.com/65535/52178323882_d8c5a83f00_b.jpg',
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
            ),
          ),
        ),
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
