import 'package:flutter/material.dart';

class ClassicSnackBar extends StatelessWidget {
  final String title;
  final String buttonTitle;
  const ClassicSnackBar(
      {required this.title, required this.buttonTitle, super.key});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      duration: const Duration(seconds: 1),
      backgroundColor: const Color.fromARGB(255, 224, 169, 6),
      content: Text(title),
      action: SnackBarAction(
          label: buttonTitle,
          onPressed: () {
            //Puede tener un metodo de otra clase
          }),
    );
  }
}
