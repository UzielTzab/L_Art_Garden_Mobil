import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:l_art_garden_mobil/Models/product.dart';

// const String _baseUrl = 'http://192.168.100.31:3001/api/products';
const String _baseUrl =
    'https://api-mysql-types-l-art-garden.onrender.com/api/products';

Future<List<Product>> getAllProducts() async {
  final response = await http.get(Uri.parse(_baseUrl));
  print("Estos son los productos");
  print(response.body);
  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    return body.map((dynamic item) => Product.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}

Future<List<Product>> getProductosByUsuarioInventario(
    int usuarioID, int inventarioID) async {
  final response = await http.post(
    Uri.parse(
        'https://api-mysql-types-l-art-garden.onrender.com/api/getProductosByUsuarioInventario'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, int>{
      'usuarioID': usuarioID,
      'inventarioID': inventarioID,
    }),
  );

  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    return body.map((dynamic item) => Product.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}
