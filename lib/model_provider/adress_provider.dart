import 'package:flutter/foundation.dart';

class AddressProvider with ChangeNotifier {
  String _street = "";
  String _state = "";
  String _country = "";
  String _postalCode = "";

  String get street => _street;
  String get state => _state;
  String get country => _country;
  String get postalCode => _postalCode;

  void setAddress(
      String street, String state, String country, String postalCode) {
    _street = street;
    _state = state;
    _country = country;
    _postalCode = postalCode;
    notifyListeners();
  }
}
