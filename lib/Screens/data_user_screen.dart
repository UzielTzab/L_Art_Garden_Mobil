import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:l_art_garden_mobil/model_provider/users_provider.dart';
import 'package:provider/provider.dart';

class DataUserScreen extends StatefulWidget {
  const DataUserScreen({super.key});

  @override
  State<DataUserScreen> createState() => _DataUserScreenState();
}

class _DataUserScreenState extends State<DataUserScreen> {
  static const Color baseColor = Color.fromARGB(255, 242, 173, 83);
  static const Color baseColorDark = Color.fromARGB(255, 163, 114, 49);
  static const Color unselectColor = Color.fromARGB(255, 107, 77, 12);
  static const Color disableColor = Color.fromARGB(255, 255, 239, 212);

  @override
  Widget build(BuildContext context) {
    UserProvider watchUserPrivider = context.watch<UserProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: baseColor,
        title: const Text(
          'Datos personales',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: baseColor,
                radius: 75,
                backgroundImage: NetworkImage('${watchUserPrivider.user.foto}'),
              ),
              const SizedBox(height: 16),
              Card(
                color: baseColor,
                child: ListTile(
                  leading: Icon(Icons.person, color: unselectColor),
                  title: Text('Nombre', style: TextStyle(color: unselectColor)),
                  subtitle: Text('${watchUserPrivider.user.nombre}',
                      style: TextStyle(color: disableColor)),
                ),
              ),
              Card(
                color: baseColor,
                child: ListTile(
                  leading: Icon(Icons.email, color: unselectColor),
                  title: Text('Correo electrónico',
                      style: TextStyle(color: unselectColor)),
                  subtitle: Text('${watchUserPrivider.user.correo}',
                      style: TextStyle(color: disableColor)),
                ),
              ),
              Card(
                color: baseColor,
                child: ListTile(
                  leading: Icon(Icons.phone, color: unselectColor),
                  title: Text('Tu teléfono',
                      style: TextStyle(color: unselectColor)),
                  subtitle: Text('${watchUserPrivider.user.telefono}',
                      style: TextStyle(color: disableColor)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
