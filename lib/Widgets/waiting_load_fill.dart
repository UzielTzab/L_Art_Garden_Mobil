import 'package:flutter/material.dart';

class WaitingPage extends StatefulWidget {
  const WaitingPage({
    Key? key,
    required this.message,
    required this.onWaitComplete,
  }) : super(key: key);

  final String message;
  final VoidCallback onWaitComplete;

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  double progress = 0;

  @override
  void initState() {
    super.initState();
    _startWaiting();
  }

  Future<void> _startWaiting() async {
    for (int i = 0; i < 100; i++) {
      await Future<dynamic>.delayed(const Duration(milliseconds: 30));
      if (mounted) {
        setState(() {
          progress = i / 100;
        });
      }
    }

    if (mounted) {
      widget.onWaitComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                value: progress, // Usa el valor de progreso aquí
                color: Color.fromARGB(255, 242, 191, 104),
              ),
              Text(
                widget.message,
                style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 242, 191, 104),
                    fontFamily: 'Capri'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
