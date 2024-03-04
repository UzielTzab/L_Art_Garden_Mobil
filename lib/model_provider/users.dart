import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  String _nombre = "hello World!";
  // String _apellido = "";
  // String _fecha_nacimiento = "";
  String _correo_electronico = '';
  // String _contrasenia = "";
  String _telefono = '';
  // String _genero = "";

  String _tipo_usuario = '';
  // bool _verificacion_datos = false;
  String? _foto = "";

  String get nombre => _nombre;
  String get correo_electronico => _correo_electronico;
  String? get foto => _foto;
  String get tipo_usuario => _tipo_usuario;
  String get telefono => _telefono;

  Future<void> setDataUser({
    required String nombre,
    // required String apellido,
    required String correo_electronico,
    required String foto,
    required String telefono,
    required String tipo_usuario,
    // required String genero,
    // required String fecha_nacimiento,
    // required bool verificacion_datos,
    // required String contrasenia,
    // required String telefono,
  }) async {
    _nombre = nombre;
    _correo_electronico = correo_electronico;
    _foto = foto;
    _telefono = telefono;
    _tipo_usuario = tipo_usuario;
    // _contrasenia = contrasenia;
    // _fecha_nacimiento = fecha_nacimiento;
    // _apellido = apellido;
    // _telefono = telefono;
    // _genero = genero;
    // _verificacion_datos = verificacion_datos;
    notifyListeners();
  }
}
