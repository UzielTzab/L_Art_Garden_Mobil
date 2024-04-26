import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:l_art_garden_mobil/Services/service_user.dart';
import 'package:l_art_garden_mobil/Services/services_flower_shops.dart';
import 'package:l_art_garden_mobil/model_provider/adress_provider.dart';
import 'package:l_art_garden_mobil/model_provider/users_provider.dart';
import 'package:provider/provider.dart';
import '../Models/flower_shops.dart';
import '../Screens/flower_shop_screen.dart';

void ShowLocationDialogGoogleMaps(
    BuildContext context, Position position) async {
  List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
  Placemark place = placemarks[0];
  AddressProvider addressProvider =
      Provider.of<AddressProvider>(context, listen: false);
  UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);

  // Crea un descriptor de imagen para el marcador
  final markerIconUser = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size.square(10), devicePixelRatio: 2.5),
      'assets/images/Logo_L_Art_garden_Pre_design_small_User.png'); // Asegúrate de que esta ruta coincide con la ubicación de tu imagen
  final markerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size.square(10), devicePixelRatio: 2.5),
      'assets/images/Logo_L_Art_garden_Pre_design_small.png');

  // Llama a la función getAllFlowerShops para obtener todas las florerías
  List<FlowerShop> flowerShops = await getAllFlowerShops();

  // Crea un marcador para cada florería
  List<Marker> markers = flowerShops.map((shop) {
    return Marker(
      markerId: MarkerId(shop.idFloreria.toString()),
      position: LatLng(shop.latitude, shop.longitude),
      icon: markerIcon, // Usa el icono personalizado
      onTap: () {
        // Navega a FlowerShopDetailScreen cuando se toque el marcador
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FlowerShopDetailScreen(flowerShop: shop),
          ),
        );
      },
    );
  }).toList();
  // Agrega un marcador para tu ubicación actual
  markers.add(
    Marker(
      markerId: MarkerId('<YOUR_LOCATION_MARKER_ID>'),
      position: LatLng(position.latitude, position.longitude),
      icon: markerIconUser, // Usa el icono personalizado
    ),
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Visualizando florerias cercanas..."),
        content: Column(
          children: <Widget>[
            SizedBox(
              height: 350, // ajusta esto a tus necesidades
              width: 600, // ajusta esto a tus necesidades
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 13.50,
                ),
                markers: Set<Marker>.of(markers),
              ),
            ),
            Flexible(
              child: Text(
                '${place.street}, ${place.subLocality}, ${place.postalCode}, ${place.administrativeArea}',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
        actions: <Widget>[
          Row(
            children: [
              Image.asset(
                'assets/images/Logo_L_Art_garden_Pre_design_small.png',
                width: 20,
                height: 20,
              ),
              Text('Florerias',
                  style: TextStyle(color: Color.fromARGB(255, 102, 83, 43))),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/Logo_L_Art_garden_Pre_design_small_User.png',
                    width: 20,
                    height: 20,
                  ),
                  Text('Tú',
                      style:
                          TextStyle(color: Color.fromARGB(255, 102, 83, 43))),
                ],
              ),
              TextButton(
                child: Text("Guardar dirección"),
                onPressed: () async {
                  String yourGoogleDirecction =
                      '${place.street}, ${place.subLocality}, ${place.postalCode}, ${place.administrativeArea}';
                  userProvider.setAddress1(yourGoogleDirecction);
                  addressProvider.setAddress(
                      place.street ?? '',
                      place.subLocality ?? '',
                      place.postalCode ?? '',
                      place.administrativeArea ?? '');

                  // Imprime los valores que se están pasando a updateUserAddresses
                  print('ID: ${userProvider.user.id.toString()}');
                  print('Direccion1: $yourGoogleDirecction');
                  print('Direccion2: ""');
                  print('Direccion3: ""');

                  // Llama al servicio para actualizar las direcciones del usuario
                  await updateUserAddresses(
                      userProvider.user.id.toString(),
                      yourGoogleDirecction,
                      "", // Direccion2
                      "" // Direccion3
                      );
                  Navigator.pop(context);
                  print(
                      "Latitude: ${position.latitude}, Longitude: ${position.longitude}");
                },
              ),
              TextButton(
                  child: Text("No me encuentro en casa"),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          ),
        ],
      );
    },
  );
}
