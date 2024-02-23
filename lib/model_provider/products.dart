import 'package:flutter/material.dart';

class ProductsProvider with ChangeNotifier {
  String _url = "";
  String get url => _url;

  Future<void> setDataProduct({
    required String url,
  }) async {
    _url = url;
    notifyListeners();
  }
}
