class Flower {
  final int indexFlower;
  final String imageUrl;
  final String descripcion;
  final int precio;
  final String? tipo;
  final int? stock;

  Flower({
    required this.indexFlower,
    required this.imageUrl,
    required this.descripcion,
    required this.precio,
    this.tipo,
    this.stock,
  });
}
