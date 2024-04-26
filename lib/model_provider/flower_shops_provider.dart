import 'package:flutter/foundation.dart';
import '../Models/flower_shops.dart';

class FlowerShopProvider with ChangeNotifier {
  List<FlowerShop> _flowerShops = [];

  List<FlowerShop> get flowerShops => _flowerShops;

  set flowerShops(List<FlowerShop> flowerShops) {
    _flowerShops = flowerShops;
    notifyListeners();
  }
}
