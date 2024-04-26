import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:permission_handler/permission_handler.dart';

void RequestLocation(BuildContext context) async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next step is to open the app settings.
      openAppSettings();
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  Position position = await Geolocator.getCurrentPosition();
  _showLocationDialog(context, position);
}

void _showLocationDialog(BuildContext context, Position position) {
  showPlatformDialog(
    context: context,
    builder: (_) => BasicDialogAlert(
      title: Text("Tu localizacion es:"),
      content: Text(
          "Latitude: ${position.latitude}, Longitude: ${position.longitude}"),
      actions: <Widget>[
        BasicDialogAction(
          title: Text("OK"),
          onPressed: () {
            Navigator.pop(context);
            print(
                "Latitude: ${position.latitude}, Longitude: ${position.longitude}");
          },
        ),
      ],
    ),
  );
}
