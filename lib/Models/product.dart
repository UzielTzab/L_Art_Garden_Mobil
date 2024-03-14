class Product {
  final int idProducto;
  final int idCategoria;
  final int idInventario;
  final String nombre;
  final String descripcion;
  final double precio;
  final String? tipo;
  final int? stock;

  Product({
    required this.idProducto,
    required this.idCategoria,
    required this.idInventario,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    this.tipo,
    this.stock,
  });

  Map<String, dynamic> toJson() {
    return {
      'IDProducto': idProducto,
      'IDCategoria': idCategoria,
      'IDInventario': idInventario,
      'NombreProducto': nombre,
      'Descripcion': descripcion,
      'Precio': precio,
      'Stock': stock
    };
  }

  factory Product.createProduct(Map<String, dynamic> json) {
    print("Valor del precio");
    print(json['Precio']);

    return Product(
        idProducto: json['ID'] != null ? json['ID'] as int : 0,
        idCategoria:
            json['IDCategoria'] != null ? json['IDCategoria'] as int : 0,
        idInventario:
            json['IDInventarios'] != null ? json['IDInventario'] as int : 0,
        nombre: json['NombreProducto'] != null
            ? json['NombreProducto'] as String
            : "",
        descripcion:
            json['Descripcion'] != null ? json['Descripcion'] as String : "",
        precio: json['Precio'] != null
            ? (json['Precio'] is int
                ? (json['Precio'] as int).toDouble()
                : json['Precio'])
            : 0.0,
        stock: json['Stock'] != null ? json['Stock'] as int : 0);
  }
  static List<Product> createProductList(dynamic responseData) {
    List<Product> products = [];
    for (var productData in responseData) {
      products.add(Product.createProduct(productData));
    }
    return products;
  }
}
