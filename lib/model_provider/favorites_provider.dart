import 'package:flutter/material.dart';
import '../Models/product.dart';

class FavoritesProvide with ChangeNotifier {
  final List<Product> _flores = [];

  List<Product> get flores => _flores;

  void addFlower({
    required int indexFlower,
    required String imageUrl,
    required String descripcion,
    required double precio,
  }) {
    _flores.add(Product(
        idProducto: indexFlower,
        idCategoria: 1,
        idInventario: 1,
        nombre: "",
        descripcion: descripcion,
        precio: precio,
        stock: 1));

    notifyListeners();
  }

  void removeFlower(int index) {
    _flores.removeWhere((flower) => flower.idProducto == index);
    notifyListeners();
  }

  bool findFlower(int index) {
    return _flores.any((flower) => flower.idProducto == index);
  }

  Product? findFlowerByIndex(int index) {
    Product? foundFlower;
    _flores.forEach((flower) {
      if (flower.idProducto == index) {
        foundFlower = flower;
      }
    });
    return foundFlower;
  }
}







// import 'package:flutter/material.dart';

// class FavoritesProvide with ChangeNotifier {
//   String _descripcion = "";
//   int _precio = 0;

//   String get descripcion => _descripcion;
//   int get precio => _precio;

//   Future<void> setDataFlower({
//     required String descripcion,
//   }) async {
//     _descripcion = descripcion;
//     _precio = precio;
//     notifyListeners();
//   }
// }
