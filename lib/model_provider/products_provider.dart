import 'package:flutter/foundation.dart';
import 'package:l_art_garden_mobil/Models/product.dart';
import 'package:l_art_garden_mobil/Services/service_product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    _products = await getAllProducts();
    notifyListeners();
  }

  List<Product> getProductsByInventoryId(int idInventario) {
    return _products
        .where((product) => product.idInventario == idInventario)
        .toList();
  }

  List<Product> getProductsByFloreriaName(String floreriaName) {
    return _products
        .where((product) => product.nombreFloreria == floreriaName)
        .toList();
  }
}
