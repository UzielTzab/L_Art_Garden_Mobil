class CartProvider {
  final String nombreProducto;
  final int idProduct;
  final int idCategoria;
  final int idInventario;
  final String description;
  final double price;
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final String image5;
  int quantityToBuy;

  CartProvider({
    required this.nombreProducto,
    required this.idProduct,
    required this.idCategoria,
    required this.idInventario,
    required this.quantityToBuy,
    required this.description,
    required this.price,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.image4,
    required this.image5,
  });
}
