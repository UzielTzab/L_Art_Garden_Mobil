import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:l_art_garden_mobil/Models/user.dart';

// const String _baseUrl =
//     'http://192.168.100.31:3001/api/user';

Future<UserModel> getUserByEmailAndPassword(
    String email, String password) async {
  final response = await http.post(
    Uri.parse('https://api-mysql-types-l-art-garden.onrender.com/api/user'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'CorreoElectronico': email,
      'Contrasenia': password,
    }),
  );

  print(response.body);
  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    return UserModel.fromJson(data['user']);
  } else {
    // Manejar error
    throw Exception('Error al cargar el usuario');
  }
}

Future<void> createUser(UserModel user) async {
  var uri = Uri.parse(
      'https://api-mysql-types-l-art-garden.onrender.com/api/createAccount');
  var request = http.MultipartRequest('POST', uri);

  request.fields['NombreUsuario'] = user.nombre;
  request.fields['FechaNacimiento'] = user.fechaNacimiento;
  request.fields['Telefono'] = user.telefono;
  request.fields['CorreoElectronico'] = user.correo;
  request.fields['Contrasenia'] = user.contrasenia;
  request.fields['Genero'] = user.genero;
  request.fields['TipoUsuarioID'] = user.tipoUsuario.toString();

  if (user.foto != null) {
    var file = await http.MultipartFile.fromPath(
      'Foto',
      user.foto!,
      contentType: MediaType('image', 'jpeg'),
    );

    request.files.add(file);
  }

  var response = await request.send();
  if (response.statusCode == 201) {
    print("UserModel created successfully.");
  } else {
    throw Exception('Failed to create user.');
  }
}

Future<void> updateUserAddresses(
    String id,
    String direccion1,
    String direccion2,
    String direccion3,
    double latitud,
    double longitud) async {
  final url = Uri.parse(
      'https://api-mysql-types-l-art-garden.onrender.com/api/UpdateAdress');

  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'ID': id,
      'Direccion1': direccion1,
      'Direccion2': direccion2,
      'Direccion3': direccion3,
      'Latitud': latitud,
      'Longitud': longitud,
    }),
  );

  if (response.statusCode == 200) {
    print('Direcciones del usuario actualizadas exitosamente');
  } else {
    throw Exception('Error al actualizar las direcciones del usuario');
  }
}
