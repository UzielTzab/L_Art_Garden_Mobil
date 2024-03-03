import 'package:l_art_garden_mobil/model_provider/cart_provider.dart';
import 'package:flutter/material.dart';

class CartListProvider with ChangeNotifier {
  final List<CartProvider> _flowers = [];

  List<CartProvider> get flowers => _flowers;

  int getQuantityByIndex(int index) {
    int quantity = 0;
    _flowers.forEach((flower) {
      if (flower.indexFlower == index) {
        quantity += flower.quantityToBuy;
      }
    });
    return quantity;
  }

  void addFlowerToCart({
    required indexFlower,
    required int quantityToBuy,
    required imageUrl,
    required description,
    required type,
    required price,
  }) {
    bool found = false;
    for (var flower in _flowers) {
      if (flower.indexFlower == indexFlower) {
        flower.quantityToBuy += quantityToBuy;
        found = true;
        break;
      }
    }
    if (!found) {
      _flowers.add(CartProvider(
        indexFlower: indexFlower,
        quantityToBuy: quantityToBuy,
        imageUrl: imageUrl,
        description: description,
        type: type,
        price: price,
      ));
    }
    notifyListeners();
  }

  void removeFlower(int index) {
    _flowers.removeWhere((flower) => flower.indexFlower == index);
    notifyListeners();
  }

  bool findFlower(int index) {
    return _flowers.any((flower) => flower.indexFlower == index);
  }

  CartProvider? findFlowerByIndex(int index) {
    CartProvider? foundFlower;
    flowers.forEach((flower) {
      if (flower.indexFlower == index) {
        foundFlower = flower;
        return;
      }
    });
    return foundFlower;
  }
}
