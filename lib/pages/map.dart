import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';
import 'package:study_at/components/bottom_nav_bar.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:study_at/components/marker_popup.dart';
import 'package:study_at/debug_pages/create_bottom.dart';
import 'package:study_at/debug_pages/database_page.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // Database reference for places (markers)
  final DatabaseReference = FirebaseDatabase.instance.ref("places");

  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    fetchMarkers();
  }

  fetchMarkers() {
    databaseReference.get().then((DataSnapshot snapshot) {
      if (snapshot.value == null) print("nulled snapshot idk why");
      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;

        if (values != null) {
          values.forEach((key, value) {
            print(
                'Adding marker at latitude ${value['latitude']} and longitude ${value['longitude']}');
            markers.add(Marker(
                point: LatLng(double.parse(value['latitude'].toString()),
                    double.parse(value['longitude'].toString())),
                width: 40,
                height: 40,
                child: Tooltip(
                    message: 'Marker tooltip',
                    child: InkWell(
                      child: Image.asset("lib/images/marker.png"),
                      // Popup passes context and other elements as argument
                      // That can be easily fetched with values[].toString
                      // Then on the popup function these elements appear
                      // basically this will work the same as the editing popup card of the debug menu
                      // where i passed lots of things as function arg.
                      onTap: () => createBottom(context),
                    ))));
          });

          setState(() {
            markers = markers;
          });
        }
      }
      return markers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.list))
        ],
      ),
      body: FlutterMap(
          options: MapOptions(
            center: LatLng(41.1780, -8.5980), // Coordenadas feup por enquanto
            zoom: 18,
          ),
          children: [
            TileLayer(
              urlTemplate:
                  'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', // URL do provedor de tiles
              subdomains: ['a', 'b', 'c'],
            ),
            CurrentLocationLayer(
              alignPositionOnUpdate: AlignOnUpdate.once,
              style: LocationMarkerStyle(
                marker: const DefaultLocationMarker(),
                markerSize: const Size(20, 20),
                markerDirection: MarkerDirection.heading,
              ),
            ),
            MarkerLayer(markers: markers),
          ]),
    );
  }
}
