import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/Screens/welcome/welcome.dart';
import 'package:l_art_garden_mobil/Services/service.dart';
import 'Models/user.dart';
// import './Screens/Welcome/WelcomeScreen.dart';

void main() {
  runApp(const MainClassLArtGarden());
}

class MainClassLArtGarden extends StatefulWidget {
  const MainClassLArtGarden({super.key});

  @override
  State<MainClassLArtGarden> createState() => _MainClassLArtGardenState();
}

class _MainClassLArtGardenState extends State<MainClassLArtGarden> {
  @override
  void initState() {
    print("Why you don't print the users?");
    super.initState();
    // getOneUser(45);
    // getAllUsers();
    // createUser(User(
    //   id: 0, // No importa el ID, ya que se asignará automáticamente en el servidor
    //   nombre: 'Uziel',
    //   apellido: 'Acasseo',
    //   fechaNacimiento: '1990-01-01',
    //   telefono: '555-1234',
    //   correo: 'uziel@example.com',
    //   contrasena: 'con',
    //   genero: 'M',
    //   verificacion: true,
    // ));
    // updateUser(
    //     User(
    //       id: 0, // No importa el ID, ya que se asignará automáticamente en el servidor
    //       nombre: 'Uziel Alejandro',
    //       apellido: 'Tzab',
    //       fechaNacimiento: '2004-01-13',
    //       telefono: '9992460093',
    //       correo: 'uzieltzab8@gmail.com',
    //       contrasena: '222443',
    //       genero: 'M',
    //       verificacion: true,
    //     ),
    //     50);
    // deleteUser(1);

    patchUser(2, {
      'nombre': 'Uziel Alejandro Tzab Puc',
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: const TextTheme(
              titleLarge: TextStyle(fontFamily: 'Capri'),
              titleMedium: TextStyle(fontFamily: 'Capri'),
              titleSmall: TextStyle(fontFamily: 'Capri'),
              // headlineLarge: TextStyle(fontFamily: 'Jost'),
              // headlineMedium: TextStyle(fontFamily: 'Jost'),
              // headlineSmall: TextStyle(fontFamily: 'Jost'),
              // bodySmall: TextStyle(fontFamily: 'Jost'),
              bodyLarge: TextStyle(fontFamily: 'Capri'),
              bodyMedium: TextStyle(fontFamily: 'Capri'),
              labelLarge: TextStyle(fontFamily: 'Capri'),
              labelMedium: TextStyle(fontFamily: 'Capri'),
              labelSmall: TextStyle(fontFamily: 'Capri')),
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 255, 140, 0)),
          useMaterial3: true),
      color: const Color.fromARGB(255, 237, 145, 88),
      debugShowCheckedModeBanner: false,
      title: 'L Art Garden',
      home: const Welcome(),
    );
  }
}