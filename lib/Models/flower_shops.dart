class FlowerShop {
  final int idFloreria;
  final int idUsuario;
  final int idInventario;
  final String nombreFloreria;
  final String descripcion;
  final String direccion;
  final String telefono;
  final String correoElectronico;
  final String redesSociales;
  final String horaApertura;
  final String horaCierre;
  final double latitude;
  final double longitude;
  String? foto;

  FlowerShop(
      {required this.idFloreria,
      required this.idUsuario,
      required this.idInventario,
      required this.nombreFloreria,
      required this.descripcion,
      required this.direccion,
      required this.telefono,
      required this.correoElectronico,
      required this.redesSociales,
      required this.foto,
      required this.horaApertura,
      required this.horaCierre,
      required this.latitude,
      required this.longitude});

  factory FlowerShop.createFlowerShop(Map<String, dynamic> json) {
    return FlowerShop(
        idFloreria: json['ID'] != null ? json['ID'] as int : 0,
        idUsuario: json['IdUsuario'] != null ? json['IdUsuario'] as int : 0,
        idInventario:
            json['IdInventario'] != null ? json['IdInventario'] as int : 0,
        nombreFloreria: json['NombreFloreria'] != null
            ? json['NombreFloreria'] as String
            : "",
        descripcion:
            json['Descripcion'] != null ? json['Descripcion'] as String : "",
        direccion: json['Direccion'] != null ? json['Direccion'] as String : "",
        telefono: json['Telefono'] != null ? json['Telefono'] as String : "",
        correoElectronico: json['CorreoElectronico'] != null
            ? json['CorreoElectronico'] as String
            : "",
        redesSociales: json['RedesSociales'] != null
            ? json['RedesSociales'] as String
            : "",
        foto: json['Foto'] != null ? json['Foto'] as String : "",
        horaApertura:
            json['HoraApertura'] != null ? json['HoraApertura'] as String : "",
        horaCierre:
            json['HoraCierre'] != null ? json['HoraCierre'] as String : "",
        latitude: json['Latitud'] != null ? json['Latitud'] as double : 0,
        longitude: json['Longitud'] != null ? json['Longitud'] as double : 0);
  }

  static List<FlowerShop> createFlowerShopList(dynamic responseData) {
    List<FlowerShop> products = [];
    for (var productData in responseData) {
      products.add(FlowerShop.createFlowerShop(productData));
    }
    return products;
  }

  @override
  String toString() {
    return 'FlowerShop {idFloreria: $idFloreria, idUsuario: $idUsuario, idInventario: $idInventario, nombreFloreria: $nombreFloreria, descripcion: $descripcion, direccion: $direccion, telefono: $telefono, correoElectronico: $correoElectronico, redesSociales: $redesSociales, horaApertura: $horaApertura, horaCierre: $horaCierre, latitude: $latitude, longitude: $longitude, foto: $foto}';
  }
}
