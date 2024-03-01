import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  String _nombre = "hello World!";
  // String _apellido = "";
  // String _fecha_nacimiento = "";
  String _correo_electronico = "";
  // String _contrasenia = "";
  // String _telefono = "";
  // String _genero = "";
  // bool _verificacion_datos = false;
  String? _foto = "";

  String get nombre => _nombre;
  // String get contrasenia => _contrasenia;
  String get correo_electronico => _correo_electronico;
  String? get foto => _foto;
  // String get fecha_nacimiento => _fecha_nacimiento;
  // String get apellido => _apellido;
  // String get telefono => _telefono;
  // String get genero => _genero;
  // bool get verificaion_datos => _verificacion_datos;

  Future<void> setDataUser({
    required String nombre,
    // required String apellido,
    required String correo_electronico,
    required String foto,
    // required String genero,
    // required String fecha_nacimiento,
    // required bool verificacion_datos,
    // required String contrasenia,
    // required String telefono,
  }) async {
    _nombre = nombre;
    _correo_electronico = correo_electronico;
    _foto = foto;
    // _contrasenia = contrasenia;
    // _fecha_nacimiento = fecha_nacimiento;
    // _apellido = apellido;
    // _telefono = telefono;
    // _genero = genero;
    // _verificacion_datos = verificacion_datos;
    notifyListeners();
  }
}
