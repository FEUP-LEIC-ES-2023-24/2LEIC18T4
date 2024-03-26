import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:study_at/components/bottom_nav_bar.dart';

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
          ]),
    );
  }
}
