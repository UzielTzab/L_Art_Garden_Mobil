import 'package:flutter/material.dart';

class DataUserScreen extends StatefulWidget {
  const DataUserScreen({super.key});

  @override
  State<DataUserScreen> createState() => _DataUserScreenState();
}

class _DataUserScreenState extends State<DataUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos personales'),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Nombre: '),
          Text('Correo electronico'),
          Text('Numero telefonico: '),
          Text('Tipo de usuario: '),
          Text('Actualizar tu contraseña: '),
        ],
      ),
    );
  }
}
