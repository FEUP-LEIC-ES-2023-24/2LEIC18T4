import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('Map'),
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
            subdomains: [
              'a',
              'b',
              'c'
            ],
          ),
        ]
      ),
    );
  }
}
