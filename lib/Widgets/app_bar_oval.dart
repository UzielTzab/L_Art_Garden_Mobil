import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Custom Flexible Space'),
          flexibleSpace: const CustomFlexibleSpace(),
        ),
        body: const Center(
          child: Text('Contenido del cuerpo'),
        ),
      ),
    );
  }
}

class CustomFlexibleSpace extends StatelessWidget {
  const CustomFlexibleSpace({super.key});
  static const Color baseColor = Color.fromARGB(179, 242, 173, 83);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.7,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.elliptical(1000, 100),
        ),
        image: DecorationImage(
          image: NetworkImage(
              'https://www.floretflowers.com/wp-content/uploads/2020/08/fow-dropdown-menu-640x480.jpg'), // Reemplaza con tu imagen
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.elliptical(1000, 100),
          ),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              baseColor.withOpacity(0.9),
              baseColor, // Amarillo con opacidad
              baseColor, // Transparente
            ],
          ),
        ),
      ),
    );
  }
}
