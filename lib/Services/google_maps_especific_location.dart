import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class GoogleMapsSpecificLocation extends StatelessWidget {
  final String nombre;
  final Position position;
  final List<Marker> markers;

  GoogleMapsSpecificLocation(
      {required this.nombre, required this.position, required this.markers});

  Future<BitmapDescriptor> _getMarkerIcon() async {
    return await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'assets/images/Logo_L_Art_garden_Pre_design_small.png', // Asegúrate de que esta ruta coincide con la ubicación de tu imagen
    );
  }

  Future<List<Marker>> _getMarkersWithCustomIcon() async {
    final icon = await _getMarkerIcon();
    return markers.map((marker) {
      return Marker(
        markerId: marker.markerId,
        position: marker.position,
        icon: icon, // Usa el icono personalizado
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Marker>>(
      future: _getMarkersWithCustomIcon(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Floreria: $nombre'),
            ),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(position.latitude, position.longitude),
                      zoom: 13.50,
                    ),
                    markers: Set<Marker>.of(snapshot.data!),
                  ),
                ),
                // Aquí puedes agregar más widgets si lo necesitas
              ],
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
