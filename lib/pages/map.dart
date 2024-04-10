import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:study_at/components/bottom_nav_bar.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
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
              alignPositionOnUpdate: AlignOnUpdate.always,
              style: LocationMarkerStyle(
                marker: const DefaultLocationMarker(),
                markerSize: const Size(20, 20),
                markerDirection: MarkerDirection.heading,
              ),
            ),
          ]),
    );
  }
}
