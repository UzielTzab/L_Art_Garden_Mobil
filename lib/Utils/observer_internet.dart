import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/model_provider/connection_status.dart';

class ObserverInternet extends NavigatorObserver {
  final ConnectionStatus connectionStatus;

  ObserverInternet({required this.connectionStatus});

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _checkConnectionStatus();
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _checkConnectionStatus();
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _checkConnectionStatus();
  }

  void _checkConnectionStatus() {
    if (!connectionStatus.isOnline) {
      showDialog(
        context: navigator!.context,
        builder: (context) => AlertDialog(
          title: const Text('No Internet Connection'),
          content: const Text('You are not connected to the internet.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }
}
