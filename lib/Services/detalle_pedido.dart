import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/detalle_pedido.dart';

Future<int> createDetallePedido(DetallePedido detallePedido) async {
  final url = Uri.parse(
      'https://api-mysql-types-l-art-garden.onrender.com/api/detallePedido');
  // final url = Uri.parse('http://192.168.100.31:3001/api/detallePedido');

  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(detallePedido.toJson()),
  );

  if (response.statusCode == 201) {
    Map<String, dynamic> data = jsonDecode(response.body);
    return data['detallePedidoID'];
  } else {
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    throw Exception('Error al crear detalle de pedido');
  }
}
