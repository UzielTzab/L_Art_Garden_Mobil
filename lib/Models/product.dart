class Product {
  final int idProducto;
  final int idCategoria;
  final int idInventario;
  final String nombre;
  final String descripcion;
  final double precio;
  final int stock;
  final String imagen1;
  final String imagen2;
  final String imagen3;
  final String imagen4;
  final String imagen5;
  final String nombreFloreria;
  final String nombreCategoria;

  Product(
      {required this.idProducto,
      required this.idCategoria,
      required this.idInventario,
      required this.nombre,
      required this.descripcion,
      required this.precio,
      required this.stock,
      required this.imagen1,
      required this.imagen2,
      required this.imagen3,
      required this.imagen4,
      required this.imagen5,
      required this.nombreFloreria,
      required this.nombreCategoria});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      idProducto: json['IDProducto'] != null ? json['IDProducto'] as int : 0,
      idCategoria: json['IDCategoria'] != null ? json['IDCategoria'] as int : 0,
      idInventario:
          json['IDInventario'] != null ? json['IDInventario'] as int : 0,
      nombre: json['NombreProducto'] != null
          ? json['NombreProducto'] as String
          : "",
      descripcion:
          json['Descripcion'] != null ? json['Descripcion'] as String : "",
      precio: json['Precio'] != null ? (json['Precio'] as num).toDouble() : 0.0,
      stock: json['Stock'] != null ? json['Stock'] as int : 0,
      imagen1: json['Imagen1'] != null ? json['Imagen1'] as String : "",
      imagen2: json['Imagen2'] != null ? json['Imagen2'] as String : "",
      imagen3: json['Imagen3'] != null ? json['Imagen3'] as String : "",
      imagen4: json['Imagen4'] != null ? json['Imagen4'] as String : "",
      imagen5: json['Imagen5'] != null ? json['Imagen5'] as String : "",
      nombreFloreria: json['NombreFloreria'] != null
          ? json['NombreFloreria'] as String
          : "",
      nombreCategoria: json['NombreCategoria'] != null
          ? json['NombreCategoria'] as String
          : "",
    );
  }
  @override
  String toString() {
    return 'Product{idProducto: $idProducto, idCategoria: $idCategoria, idInventario: $idInventario, nombre: $nombre, descripcion: $descripcion, precio: $precio, stock: $stock, imagen1: $imagen1, imagen2: $imagen2, imagen3: $imagen3, imagen4: $imagen4, imagen5: $imagen5, nombreFloreria: $nombreFloreria, nombreCategoria: $nombreCategoria}';
  }
}
