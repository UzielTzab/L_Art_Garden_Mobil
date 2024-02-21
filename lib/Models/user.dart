class User {
  int id;
  String nombre;
  String correo;
  String telefono;
  String contrasena;
  String fechaNacimiento;
  String genero;
  User({
    required this.id,
    required this.nombre,
    required this.telefono,
    required this.correo,
    required this.contrasena,
    required this.fechaNacimiento,
    required this.genero,
  });
  Map<String, dynamic> toJson() {
    return {
      'Id_Usuario': id,
      'Nombre': nombre,
      'Fecha_Nacimiento': fechaNacimiento,
      'Telefono': telefono,
      'Correo_Electronico': correo,
      'Contraseña': contrasena,
      'Genero': genero,
    };
  }

  factory User.createUser(Map<String, dynamic> json) {
    print("Printing user JSON data:");
    print(json);

    final user = User(
      id: json['Id_Usuario'] != null ? json['Id_Usuario'] as int : 0,
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
      telefono: json['Telefono'] != null ? json['Telefono'] as String : "",
      genero: json['Genero'] != null ? json['Genero'] as String : "",
    );

    print("User created: $user");

    return user;
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
    );
  }
}
