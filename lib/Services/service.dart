import 'dart:convert';

import 'package:http/http.dart' as http;
import '../Models/user.dart';

const String ipDirection = "10.2.8.99";
const String url = 'http://$ipDirection:3004/api/users';

// Future<User> getOneUser(int index) async {
//   final response = await http.get(Uri.parse('$url/$index'));

//   if (response.statusCode == 200) {
//     print(response.body);
//     return User.createUser(jsonDecode(response.body));
//   } else {
//     throw Exception('Error al conectar a la API');
//   }
// }

Future<User> getUserByEmailAndPassword(String email, String password) async {
  final response = await http
      .get(Uri.parse('$url?correo_electronico=$email&contraseña=$password'));

  if (response.statusCode == 200) {
    print('respuesta del inicio de sesion ${response.body}');
    final dynamic responseData = jsonDecode(response.body);
    return User.createUser(responseData);
  } else {
    throw Exception('Error al conectar a la API');
  }
}

Future<List<User>> getAllUsers() async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    print(response.body);
    // Si la respuesta es exitosa (código de estado 200), se analiza el cuerpo de la respuesta y se crea una lista de usuarios.
    final List<dynamic> responseData = jsonDecode(response.body);
    List<User> users = [];
    for (var data in responseData) {
      users.add(User.createUser(data));
    }
    return users;
  } else {
    // Si la respuesta no es exitosa, se lanza una excepción.
    throw FormatException('Error al conectarse con la ruta');
  }
}

Future<User> createUser(User user) async {
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(user.toJson()),
  );

  if (response.statusCode == 201) {
    print(response.body);
    return User.createUser(jsonDecode(response.body));
  } else {
    print(response.body);
    throw Exception('Error al conectar a la API');
  }
}

Future<User> updateUser(User user, int id) async {
  final response = await http.put(
    Uri.parse('$url/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(user.toJson()),
  );

  if (response.statusCode == 200) {
    print(response.body);
    return User.uptadeUser(jsonDecode(response.body));
  } else {
    throw Exception('Error al conectar a la API');
  }
}

Future<void> deleteUser(int id) async {
  final response = await http.delete(
    Uri.parse('$url/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    print('Usuario eliminado exitosamente');
  } else {
    throw Exception('Error al conectar a la API');
  }
}

Future<User> patchUser(int id, Map<String, dynamic> updatedFields) async {
  final response = await http.patch(
    Uri.parse('$url/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(updatedFields),
  );

  if (response.statusCode == 200) {
    print(response.body);
    return User.updateUser(jsonDecode(response.body));
  } else {
    throw Exception('Error al conectar a la API');
  }
}
