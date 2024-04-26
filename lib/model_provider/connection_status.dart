import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectionStatus extends ChangeNotifier {
  bool _isOnline = true;

  bool get isOnline => _isOnline;

  void startChecking() {
    InternetConnectionChecker().onStatusChange.listen((status) {
      _isOnline = (status == InternetConnectionStatus.connected);
      notifyListeners();
    });
  }
}
