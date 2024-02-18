import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/Screens/Home/Main_Store/Main_Store.dart';
import 'package:l_art_garden_mobil/Screens/LoginScreen/loginScreen.dart';
import 'package:l_art_garden_mobil/Screens/Register/Register.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.width;
    print(heightScreen / 4);
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Image.network(
            'https://viajabonito.mx/wp-content/uploads/2021/09/Flores-de-d%C2%A1a-de-muertos-Portada2.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Fondo con degradado
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color.fromARGB(219, 0, 0, 0),
                  Color.fromARGB(
                      0, 73, 73, 73), // Transparente en la parte superior
                ],
              ),
            ),
          ),
          // Imagen de fondo
          // Contenido adicional (si lo necesitas)
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            child: GestureDetector(
              child: const Text(
                'L-Art Garden',
                style: TextStyle(
                  fontFamily: 'Arial',
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.83,
            ),
            child: ElevatedButton.icon(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 50.0)),
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 241, 185, 65)),
                elevation: MaterialStateProperty.resolveWith(
                    (states) => 0), // Establecer la elevación a cero
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
                // Funcionalidad del botón
              },
              icon: const Icon(
                Icons.local_florist_outlined,
                color: Colors.white,
              ), // Icono de Facebook
              label: const Text("Iniciar sesión",
                  style: TextStyle(fontFamily: 'Arial', color: Colors.white)),
            ),
          ),

          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "¿No tienes cuenta?",
                  style: TextStyle(
                      fontFamily: 'Capri',
                      color: Colors.amber,
                      fontSize: 15,
                      letterSpacing: 2),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const registerScreen()));
                  },
                  child: const Text(
                    "Crear",
                    style: TextStyle(
                        fontFamily: 'Capri',
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.amber,
                        color: Colors.amber,
                        fontSize: 15,
                        letterSpacing: 2),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.95),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MainStore()));
              },
              child: const Text(
                "Entrar como invitado",
                style: TextStyle(
                    fontFamily: 'Capri',
                    decoration: TextDecoration.underline,
                    decorationColor: Color.fromARGB(255, 210, 66, 169),
                    color: Color.fromARGB(255, 238, 87, 195),
                    fontSize: 15,
                    letterSpacing: 2),
              ),
            ),
          )
        ],
      ),
    );
  }
}
