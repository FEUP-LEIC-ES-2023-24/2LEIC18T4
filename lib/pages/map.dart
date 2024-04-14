import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';
import 'package:study_at/components/bottom_nav_bar.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:study_at/debug_pages/create_bottom.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  /*
  static final List<Marker> _markers = [const LatLng(41.1780, -8.5980)]
      .map((markerPosition) => Marker(
            point: markerPosition,
            width: 40,
            height: 40,
            child: Image.asset("lib/images/marker.png"),
            builder: (context) {
              return GestureDetector(
                onTap: () {
                  
                },
              )
            } 
          ))
      .toList();
  */

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
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(41.1780, -8.5980),
                  width: 40,
                  height: 40,
                  child: Tooltip(
                    message: 'Marker tooltip',
                    child: InkWell(
                      child: Image.asset("lib/images/marker.png"),
                      onTap: () => createBottom(context),
                    )
                  )
                ),
              ],
            ),
          ]),
    );
  }
}
