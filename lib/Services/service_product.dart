import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/product.dart';

const String ipDirection = "10.2.8.236";
const String url = 'http://$ipDirection:4004/api/Productos';

Future<List<Product>> getAllProducts() async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    print("Hola, esta es el cuerpo de la respuesta");
    print(response.body);
    final dynamic responseData = jsonDecode(response.body);
    List<Product> products = Product.createProductList(responseData);
    print('Todos los productos ${products}');
    return products;
  } else {
    throw Exception('Error al conectar a la API');
  }
}
