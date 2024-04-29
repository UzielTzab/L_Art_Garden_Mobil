import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/pedido.dart';

Future<int> createPedido(Pedido pedido) async {
  final url = Uri.parse(
      'https://api-mysql-types-l-art-garden.onrender.com/api/addPedido');
  // final url = Uri.parse('http://192.168.100.31:3001/api/addPedido');
  // final url = Uri.parse('http://10.2.9.87:3001/api/addPedido');

  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(pedido.toJson()),
  );

  if (response.statusCode == 201) {
    Map<String, dynamic> data = jsonDecode(response.body);
    return data['pedidoID'];
  } else {
    print('Response status: ${response.statusCode}');
    print('Response headers: ${response.headers}');
    print('Response body: ${response.body}');
    throw Exception('Error al crear pedido');
  }
}

Future<List<Pedido>> getPedidosByUserId(int userId) async {
  final url =
      Uri.parse('https://api-mysql-types-l-art-garden.onrender.com/api/pedido');

  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({'IDUsuario': userId}),
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => Pedido.fromJson(item)).toList();
  } else {
    print('Response status: ${response.statusCode}');
    print('Response headers: ${response.headers}');
    print('Response body: ${response.body}');
    throw Exception('Error al obtener pedidos');
  }
}
