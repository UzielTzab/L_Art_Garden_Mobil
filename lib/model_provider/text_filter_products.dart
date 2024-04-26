import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/Models/product.dart';
import 'package:provider/provider.dart';

class SearchProvider with ChangeNotifier {
  String _searchText = '';

  String get searchText => _searchText;

  void setSearchText(String text) {
    _searchText = text;
    notifyListeners();
  }

  List<Product> filterProducts(List<Product> allProducts) {
    if (_searchText == '') {
      return allProducts;
    } else {
      return allProducts.where((product) {
        return product.nombre.toLowerCase().contains(_searchText.toLowerCase());
      }).toList();
    }
  }
}
