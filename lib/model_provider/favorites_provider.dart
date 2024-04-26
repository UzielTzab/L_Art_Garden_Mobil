import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/Models/product.dart';

class FavoritesProvider with ChangeNotifier {
  final List<Product> _favoriteProducts = [];

  List<Product> get favoriteProducts => _favoriteProducts;

  void addProduct(Product product) {
    _favoriteProducts.add(product);
    notifyListeners();
  }

  void removeProduct(int productId) {
    _favoriteProducts.removeWhere((product) => product.idProducto == productId);
    notifyListeners();
  }

  bool findProduct(int productId) {
    return _favoriteProducts.any((product) => product.idProducto == productId);
  }

  Product? findProductById(int productId) {
    try {
      return _favoriteProducts
          .firstWhere((product) => product.idProducto == productId);
    } catch (e) {
      return null;
    }
  }
}
