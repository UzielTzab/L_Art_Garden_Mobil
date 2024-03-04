import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/model_provider/users.dart';
import 'package:provider/provider.dart';

class DataUserScreen extends StatefulWidget {
  const DataUserScreen({super.key});

  @override
  State<DataUserScreen> createState() => _DataUserScreenState();
}

class _DataUserScreenState extends State<DataUserScreen> {
  Color colorDivider = Color.fromARGB(255, 179, 140, 23);
  @override
  Widget build(BuildContext context) {
    UserProvider watchUserPrivider = context.watch<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 235, 168, 35),
        title: const Text('Datos personales'),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 500,
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
          child: ListView.builder(
            itemCount:
                6, // Adjust the itemCount according to the number of items you want to display
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return ListTile(
                    title: Text(
                      'Nombre: ${watchUserPrivider.nombre}',
                      style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 161, 123, 10)),
                    ),
                  );
                case 1:
                  return Divider(
                    color: colorDivider,
                    thickness: 10,
                    height: 5,
                    indent: 30,
                  );
                case 2:
                  return ListTile(
                    title: Text(
                      'Correo electrónico ${watchUserPrivider.correo_electronico}',
                      style: TextStyle(fontSize: 20, color: colorDivider),
                    ),
                  );
                case 3:
                  return Divider(
                    color: colorDivider,
                    thickness: 10,
                    height: 5,
                    indent: 30,
                  );
                case 4:
                  return ListTile(
                    title: Text(
                      'telefono ${watchUserPrivider.telefono}',
                      style: TextStyle(fontSize: 20, color: colorDivider),
                    ),
                  );
                case 5:
                  return ListTile(
                    title: Text(
                      'Tipo de cuenta ${watchUserPrivider.tipo_usuario}',
                      style: TextStyle(fontSize: 20, color: colorDivider),
                    ),
                  );
                // Add more cases for additional items if needed
                default:
                  return Container(); // Return an empty container as a fallback
              }
            },
          ),
        ),
      ),
    );
  }
}
