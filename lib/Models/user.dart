import 'dart:convert';

class User {
  int id;
  String nombre;
  String correo;
  String telefono;
  String contrasena;
  String fechaNacimiento;
  String genero;
  int? tipoUsuario;
  String? foto;
  User({
    required this.id,
    required this.nombre,
    required this.telefono,
    required this.correo,
    required this.contrasena,
    required this.fechaNacimiento,
    required this.genero,
    required this.tipoUsuario,
    required this.foto,
  });
  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Nombre': nombre,
      'FechaNacimiento': fechaNacimiento,
      'Telefono': telefono,
      'CorreoElectronico': correo,
      'Contraseña': contrasena,
      'Genero': genero,
      'TipoUsuarioID': tipoUsuario,
      'Foto': foto,
    };
  }

  factory User.createUser(Map<String, dynamic> json) {
    final fotoData = json['Foto'] != null ? json['Foto']['data'] : null;
    String fotoBase64 = "";

    if (fotoData != null) {
      // Convertir los bytes de la foto a una cadena base64
      fotoBase64 = base64Encode(List<int>.from(fotoData));
    }

    return User(
      id: json['ID'] != null ? json['ID'] as int : 0,
      nombre:
          json['NombreUsuario'] != null ? json['NombreUsuario'] as String : '',
      fechaNacimiento: json['FechaNacimiento'] != null
          ? json['FechaNacimiento'] as String
          : '',
      correo: json['CorreoElectronico'] != null
          ? json['CorreoElectronico'] as String
          : '',
      contrasena:
          json['Contraseña'] != null ? json['Contraseña'] as String : '',
      telefono: json['Telefono'] != null ? json['Telefono'] as String : '',
      genero: json['Genero'] != null ? json['Genero'] as String : '',
      tipoUsuario:
          json['TipoUsuarioID'] != null ? json['TipoUsuarioID'] as int : 1,
      foto: fotoBase64,
    );
  }

  factory User.uptadeUser(Map<String, dynamic> json) {
    return User(
      id: json['Id_Usuario'] != null ? json['Id_Usuario'] as int : 0,
      nombre: json['Nombre'] != null ? json['Nombre'] as String : '',
      fechaNacimiento: json['FechaNacimiento'] != null
          ? json['FechaNacimiento'] as String
          : '',
      correo: json['CorreoElectronico'] != null
          ? json['CorreoElectronico'] as String
          : '',
      contrasena:
          json['Contraseña'] != null ? json['Contraseña'] as String : '',
      telefono: json['Telefono'] != null ? json['Telefono'] as String : "",
      genero: json['Genero'] != null ? json['Genero'] as String : "",
      tipoUsuario: json['TipoUsuario'] != null ? json['TipoUsuario'] as int : 0,
      foto: json['Foto'] != null ? json["Foto"] as String : null,
    );
  }
  factory User.updateUser(Map<String, dynamic> json) {
    return User(
      id: json['Id_Usuario'] != null ? json['Id_Usuario'] as int : 0,
      nombre: json['Nombre'] != null ? json['Nombre'] as String : '',
      fechaNacimiento: json['FechaNacimiento'] != null
          ? json['FechaNacimiento'] as String
          : '',
      correo: json['CorreoElectronico'] != null
          ? json['CorreoElectronico'] as String
          : '',
      contrasena:
          json['Contraseña'] != null ? json['Contraseña'] as String : '',
      telefono: json['Telefono'] != null ? json['Telefono'] as String : "",
      genero: json['Genero'] != null ? json['Genero'] as String : "",
      tipoUsuario: json['TipoUsuario'] != null ? json['TipoUsuario'] as int : 1,
      foto: json['Foto'] != null ? json["Foto"] as String : null,
    );
  }
}
