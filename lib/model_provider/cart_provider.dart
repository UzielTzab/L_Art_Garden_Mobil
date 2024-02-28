import 'package:flutter/material.dart';
import '../Models/product.dart';

class CartProvider with ChangeNotifier {
  final List<Flower> _flores = [];

  List<Flower> get flores => _flores;

  void addFlower({
    required int indexFlower,
    required String imageUrl,
    required String descripcion,
    required int precio,
  }) {
    _flores.add(Flower(
        indexFlower: indexFlower,
        imageUrl: imageUrl,
        descripcion: descripcion,
        precio: precio));
    notifyListeners();
  }

  void removeFlower(int index) {
    _flores.removeWhere((flower) => flower.indexFlower == index);
    notifyListeners();
  }

  bool findFlower(int index) {
    return _flores.any((flower) => flower.indexFlower == index);
  }

  Flower? findFlowerByIndex(int index) {
    Flower? foundFlower;
    _flores.forEach((flower) {
      if (flower.indexFlower == index) {
        foundFlower = flower;
      }
    });
    return foundFlower;
  }
}
