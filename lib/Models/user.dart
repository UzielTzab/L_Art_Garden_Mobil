import 'dart:convert';

class UserModel {
  // Definición de las propiedades de la clase UserModel
  int id;
  String nombre;
  String correo;
  String telefono;
  String contrasenia;
  String fechaNacimiento;
  String genero;
  int tipoUsuario;
  String? foto;
  double? latitud;
  double? longitud;
  String direccion1;
  String direccion2;
  String direccion3;

  // Constructor de la clase UserModel
  // Todos los parámetros son requeridos
  UserModel({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.telefono,
    required this.contrasenia,
    required this.fechaNacimiento,
    required this.genero,
    required this.tipoUsuario,
    required this.foto,
    required this.latitud,
    required this.longitud,
    required this.direccion1,
    required this.direccion2,
    required this.direccion3,
  });

  // Método para convertir un objeto UserModel a un Map (para luego convertirlo a JSON)
  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'NombreUsuario': nombre,
      'FechaNacimiento': fechaNacimiento,
      'Telefono': telefono,
      'CorreoElectronico': correo,
      'Contrasenia': contrasenia,
      'Genero': genero,
      'TipoUsuarioID': tipoUsuario,
      'Foto': foto,
      'Altitud': latitud,
      'Longitud': longitud,
      'Direccion1': direccion1,
      'Direccion2': direccion2,
      'Direccion3': direccion3,
    };
  }

  // Método de fábrica para crear un objeto UserModel a partir de un Map (proveniente de un JSON)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Se retorna una nueva instancia de UserModel con los datos obtenidos del JSON
    return UserModel(
      id: json['ID'] != null ? json['ID'] as int : 0,
      nombre:
          json['NombreUsuario'] != null ? json['NombreUsuario'] as String : '',
      fechaNacimiento: json['FechaNacimiento'] != null
          ? json['FechaNacimiento'] as String
          : '',
      correo: json['CorreoElectronico'] != null
          ? json['CorreoElectronico'] as String
          : '',
      contrasenia:
          json['Contraseña'] != null ? json['Contraseña'] as String : '',
      telefono: json['Telefono'] != null ? json['Telefono'] as String : '',
      genero: json['Genero'] != null ? json['Genero'] as String : '',
      tipoUsuario:
          json['TipoUsuarioID'] != null ? json['TipoUsuarioID'] as int : 1,
      foto: json['Foto'] != null ? json['Foto'] as String : "",
      latitud: json['Latitud'] != null ? json['Latitud'] as double : 0,
      longitud: json['Longitud'] != null ? json['Longitud'] as double : 0,
      direccion1:
          json['Direccion1'] != null ? json['Direccion1'] as String : "",
      direccion2:
          json['Direccion2'] != null ? json['Direccion2'] as String : "",
      direccion3:
          json['Direccion3'] != null ? json['Direccion3'] as String : "",
    );
  }
}
