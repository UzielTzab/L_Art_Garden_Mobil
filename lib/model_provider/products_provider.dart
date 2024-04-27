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

  Product getProductById(int idProducto) {
    return _products.firstWhere(
      (product) => product.idProducto == idProducto,
      orElse: () => Product(
        idProducto: 0,
        idCategoria: 0,
        idInventario: 0,
        nombre: '',
        descripcion: '',
        precio: 0.0,
        stock: 0,
        imagen1: '',
        imagen2: '',
        imagen3: '',
        imagen4: '',
        imagen5: '',
        nombreFloreria: '',
        nombreCategoria: '',
      ),
    );
  }
}
