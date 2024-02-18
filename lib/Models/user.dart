class User {
  int id;
  String nombre;
  String apellido;
  String correo;
  String telefono;
  String contrasena;
  String fechaNacimiento;
  String genero;
  bool verificacion;
  User({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.telefono,
    required this.correo,
    required this.contrasena,
    required this.fechaNacimiento,
    required this.genero,
    required this.verificacion,
  });
  Map<String, dynamic> toJson() {
    return {
      'Id_Usuario': id,
      'Nombre': nombre,
      'Apellido': apellido,
      'Fecha_Nacimiento': fechaNacimiento,
      'Telefono': telefono,
      'Correo_Electronico': correo,
      'Contraseña': contrasena,
      'Genero': genero,
      'Verificacion_Datos': verificacion,
    };
  }

  factory User.createUser(Map<String, dynamic> json) {
    print("Printing user JSON data:");
    print(json);

    final user = User(
      id: json['Id_Usuario'] != null ? json['Id_Usuario'] as int : 0,
      nombre: json['Nombre'] != null ? json['Nombre'] as String : '',
      apellido: json['Apellido'] != null ? json['Apellido'] as String : '',
      fechaNacimiento: json['Fecha_Nacimiento'] != null
          ? json['Fecha_Nacimiento'] as String
          : '',
      correo: json['Correo_Electronico'] != null
          ? json['Correo_Electronico'] as String
          : '',
      contrasena:
          json['Contraseña'] != null ? json['Contraseña'] as String : '',
      telefono: json['Telefono'] != null ? json['Telefono'] as String : "",
      genero: json['Genero'] != null ? json['Genero'] as String : "",
      verificacion: json['Verificacion_Datos'] != null
          ? json['Verificacion_Datos'] as bool
          : false,
    );

    print("User created: $user");

    return user;
  }
  factory User.uptadeUser(Map<String, dynamic> json) {
    return User(
      id: json['Id_Usuario'] != null ? json['Id_Usuario'] as int : 0,
      nombre: json['Nombre'] != null ? json['Nombre'] as String : '',
      apellido: json['Apellido'] != null ? json['Apellido'] as String : '',
      fechaNacimiento: json['Fecha_Nacimiento'] != null
          ? json['Fecha_Nacimiento'] as String
          : '',
      correo: json['Correo_Electronico'] != null
          ? json['Correo_Electronico'] as String
          : '',
      contrasena:
          json['Contraseña'] != null ? json['Contraseña'] as String : '',
      telefono: json['Telefono'] != null ? json['Telefono'] as String : "",
      genero: json['Genero'] != null ? json['Genero'] as String : "",
      verificacion: json['Verificacion_Datos'] != null
          ? json['Verificacion_Datos'] as bool
          : false,
    );
  }
  factory User.updateUser(Map<String, dynamic> json) {
    return User(
      id: json['Id_Usuario'] != null ? json['Id_Usuario'] as int : 0,
      nombre: json['Nombre'] != null ? json['Nombre'] as String : '',
      apellido: json['Apellido'] != null ? json['Apellido'] as String : '',
      fechaNacimiento: json['Fecha_Nacimiento'] != null
          ? json['Fecha_Nacimiento'] as String
          : '',
      correo: json['Correo_Electronico'] != null
          ? json['Correo_Electronico'] as String
          : '',
      contrasena:
          json['Contraseña'] != null ? json['Contraseña'] as String : '',
      telefono: json['Telefono'] != null ? json['Telefono'] as String : "",
      genero: json['Genero'] != null ? json['Genero'] as String : "",
      verificacion: json['Verificacion_Datos'] != null
          ? json['Verificacion_Datos'] as bool
          : false,
    );
  }
}
