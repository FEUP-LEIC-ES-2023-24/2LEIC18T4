import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:osm_nominatim/osm_nominatim.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:study_at/components/marker_popup.dart';
import 'package:study_at/debug_pages/database_page.dart';
import 'package:study_at/pages/search_page.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // Database reference for places (markers)
  final DatabaseReference = FirebaseDatabase.instance.ref("places");
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
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
                    message: value['name'].toString(),
                    child: InkWell(
                      child: Image.asset("lib/images/marker.png"),
                      // Popup passes context and other elements as argument
                      // That can be easily fetched with values[].toString
                      // Then on the popup function these elements appear
                      // basically this will work the same as the editing popup card of the debug menu
                      // where i passed lots of things as function arg.
                      onTap: () => createMarkerPopup(
                          context,
                          value['name'].toString(),
                          value['imageLink'].toString()),
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
              icon: Icon(Icons.list)),
        ],
      ),
      body: FlutterMap(
          mapController: _mapController,
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
              followOnLocationUpdate: FollowOnLocationUpdate.once,
              style: LocationMarkerStyle(
                marker: const DefaultLocationMarker(),
                markerSize: const Size(20, 20),
                markerDirection: MarkerDirection.heading,
              ),
            ),
            MarkerLayer(markers: markers),

            // barra de pesquisa feinha... depois refaz-se
            // usa api nominatim da OSM para pesquisar e centrar o mapa
            // na nova localização
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Where do you want to study at?',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                ),
                onSubmitted: (value) {
                  _search(context);
                },
              ),
            ),
          ]),
    );
  }

  Future<void> _search(BuildContext context) async {
    final String query = _searchController.text;
    if (query.isNotEmpty) {
      final LatLng position = await searchPlace(query);
      _mapController.move(position, 18);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please enter a place to search.")));
    }
  }

  Future<LatLng> searchPlace(value) async {
    final searchResult = await Nominatim.searchByName(query: value, limit: 1);
    LatLng position = LatLng(searchResult.single.lat, searchResult.single.lon);
    return position;
  }
}