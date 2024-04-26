import 'dart:convert';

import 'package:http/http.dart' as http;
import '../Models/flower_shops.dart';

// const String ipDirection = "192.168.100.31";
// const String url = 'http://$ipDirection:3001/api/users';
const String url = 'https://testappapi.onrender.com/api/florerias';

Future<List<FlowerShop>> getAllFlowerShops() async {
  final responsive = await http.get(Uri.parse(url));

  if (responsive.statusCode == 200) {
    print(
        'Conexion a la api exitosa, esto es la respuesta: ${responsive.body}');
    final List<dynamic> responseData = jsonDecode(responsive.body);
    List<FlowerShop> flowerShops =
        FlowerShop.createFlowerShopList(responseData);
    return flowerShops;
  } else {
    throw Exception('Error al conectar con la api');
  }
}
