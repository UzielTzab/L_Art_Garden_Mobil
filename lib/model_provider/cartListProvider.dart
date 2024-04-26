import 'package:flutter/foundation.dart';
import 'package:l_art_garden_mobil/model_provider/cart_provider.dart';

class CartListProvider with ChangeNotifier {
  final List<CartProvider> _products = [];

  List<CartProvider> get products => _products;

  int getQuantityByIndex(int index) {
    for (var product in _products) {
      if (product.idProduct == index) {
        return product.quantityToBuy;
      }
    }
    return 0;
  }

  void addProductToCart({
    required int indexProduct,
    required int idCategory,
    required int idInvetory,
    required int quantityToBuy,
    required String image1,
    required String image2,
    required String image3,
    required String image4,
    required String image5,
    required String description,
    required int stock,
    required double price,
  }) {
    bool found = false;
    for (var product in _products) {
      if (product.idProduct == indexProduct) {
        product.quantityToBuy += quantityToBuy;
        found = true;
        break;
      }
    }
    if (!found) {
      _products.add(CartProvider(
        idProduct: indexProduct,
        idCategoria: idCategory,
        idInventario: idInvetory,
        quantityToBuy: quantityToBuy,
        image1: image1,
        image2: image2,
        image3: image3,
        image4: image4,
        image5: image5,
        description: description,
        price: price,
      ));
      ;
    }
    notifyListeners();
  }

  void removeAllFlower(int indexProduct) {
    _products.removeWhere((product) => product.idProduct == indexProduct);
    notifyListeners();
  }

  void removeOneFlower(int productId) {
    // Find the product in the cart
    var product =
        _products.firstWhere((product) => product.idProduct == productId);

    // If the product's quantity is more than 1, decrease the quantity
    if (product.quantityToBuy > 1) {
      product.quantityToBuy--;
    } else {
      // If the product's quantity is 1, remove the product from the cart
      _products.remove(product);
    }

    // Notify listeners to update the UI
    notifyListeners();
  }

  void clearCart() {
    _products.clear();
    notifyListeners();
  }
}
