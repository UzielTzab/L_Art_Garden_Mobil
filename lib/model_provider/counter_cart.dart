import 'package:flutter/material.dart';

class CounterCartProvider with ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;

  Future<void> setDataCounter({
    required int counter,
  }) async {
    _counter = counter;
    notifyListeners();
  }
}
