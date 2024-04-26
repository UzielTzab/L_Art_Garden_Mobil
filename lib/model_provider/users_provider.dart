import 'package:flutter/material.dart';
import '../Models/user.dart';

class UserProvider with ChangeNotifier {
  UserModel _user = UserModel(
      id: 0,
      nombre: '',
      correo: '',
      telefono: '',
      contrasenia: '',
      fechaNacimiento: '',
      genero: '',
      tipoUsuario: 0,
      foto: '',
      latitud: 0,
      longitud: 0,
      direccion1: '',
      direccion2: '',
      direccion3: '');

  UserModel get user {
    return _user;
  }

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  void setAddress1(String address) {
    _user.direccion1 = address;
    notifyListeners();
  }
}
