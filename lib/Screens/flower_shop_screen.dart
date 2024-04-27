import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:l_art_garden_mobil/Models/flower_shops.dart';
import 'package:l_art_garden_mobil/Screens/product_screee.dart';
import 'package:l_art_garden_mobil/Services/google_maps_especific_location.dart';
import 'package:l_art_garden_mobil/Utils/get_status_flower_shop.dart';
import 'package:l_art_garden_mobil/model_provider/products_provider.dart';
import 'package:provider/provider.dart';
import '../AnimationRoutes/routeAnimatedBottomToTop.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class FlowerShopDetailScreen extends StatelessWidget {
  static const Color baseColor = Color.fromARGB(255, 242, 173, 83);
  static const Color baseColorDark = Color.fromARGB(255, 163, 114, 49);
  static const Color unselectColor = Color.fromARGB(255, 107, 77, 12);
  static const Color disableColor = Color.fromARGB(255, 193, 193, 193);
  final FlowerShop flowerShop;

  FlowerShopDetailScreen({required this.flowerShop});

  @override
  Widget build(BuildContext context) {
    ProductProvider watchProductsProvider = context.watch<ProductProvider>();

    var filteredProducts = watchProductsProvider.products
        .where((product) => product.idInventario == flowerShop.idFloreria)
        .toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: baseColor,
        title: Text(flowerShop.nombreFloreria,
            style: TextStyle(color: Colors.white)),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.27,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://dinorank.com/img/dinobrain/105769/imagenddabae3ff465fd733b8b459dff5f25db.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(1),
                          Colors.black.withOpacity(.0),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            flowerShop.nombreFloreria,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            flowerShop.descripcion,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.timer, color: baseColor, size: 13),
                              Text(
                                flowerShop.horaApertura +
                                    ' - ' +
                                    flowerShop.horaCierre,
                                style: TextStyle(
                                  color: baseColor,
                                  fontSize: 13,
                                ),
                              ),
                              VerticalDivider(
                                color: Color.fromARGB(255, 255, 255, 255),
                                thickness: 10,
                              ),
                              Text(
                                getShopStatus(flowerShop.horaApertura,
                                    flowerShop.horaCierre),
                                style: TextStyle(
                                  color: getShopStatus(flowerShop.horaApertura,
                                              flowerShop.horaCierre) ==
                                          'Abierto'
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.directions,
                                    color: baseColor,
                                    size: 13,
                                  ),
                                  Text(
                                    flowerShop.direccion,
                                    style: TextStyle(
                                      color: baseColor,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  double flowerShopLatitude =
                                      flowerShop.latitude;
                                  double flowerShopLongitude =
                                      flowerShop.longitude;

                                  Position flowerShopPosition = Position(
                                    latitude: flowerShopLatitude,
                                    longitude: flowerShopLongitude,
                                    timestamp: DateTime.now(),
                                    accuracy: 0.0,
                                    altitude: 0.0,
                                    heading:
                                        0.0, // proporciona un valor predeterminado para la dirección
                                    speed:
                                        0.0, // proporciona un valor predeterminado para la velocidad
                                    speedAccuracy:
                                        0.0, // proporciona un valor predeterminado para la precisión de la velocidad
                                  );

                                  Marker flowerShopMarker = Marker(
                                    markerId: MarkerId('<YOUR_MARKER_ID>'),
                                    position: LatLng(flowerShopLatitude,
                                        flowerShopLongitude),
                                  );

                                  List<Marker> markers = [flowerShopMarker];

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          GoogleMapsSpecificLocation(
                                        nombre: flowerShop.nombreFloreria,
                                        position: flowerShopPosition,
                                        markers: markers,
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text("Ver en el mapa",
                                        style: TextStyle(color: baseColor)),
                                    Icon(Icons.location_on,
                                        color: baseColor, size: 13),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text('FLores disponibles:')),
                )
              ],
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Número de columnas
              crossAxisSpacing: 10, // Espacio entre columnas
              mainAxisSpacing: 10, // Espacio entre filas
              childAspectRatio:
                  0.6, // Relación de aspecto de los elementos de la cuadrícula
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRoutesFree.createPageRoute(
                              ProductScreen(filteredProducts[index].idProducto),
                            ),
                          );
                        },
                        child: Image.network(
                            'https://floresfinas.oss-us-east-1.aliyuncs.com/mj-v1/arreglo-floral-m4067-1.webp'),
                      ),
                      Text(filteredProducts[index].nombre),
                      Text('${filteredProducts[index].precio} MXN'),
                    ],
                  ),
                );
              },
              childCount: filteredProducts.length,
            ),
          ),
        ],
      ),
    );
  }
}
