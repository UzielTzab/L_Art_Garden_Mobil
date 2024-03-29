import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/model_provider/products_test_provider.dart';
import 'package:provider/provider.dart';
import 'mainStore.dart';

import '../model_provider/users.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    print("Estoy en welcome");

    ProductsTestProvider watchProdutTestProvider =
        context.watch<ProductsTestProvider>();
    print("Lista en el welcome");
    watchProdutTestProvider.convertAllProducts();
    for (var flower in watchProdutTestProvider.flores) {
      print(
          "idProducto: ${flower.idProducto} idCategoria ${flower.idCategoria}: idInventario ${flower.idInventario}: nombre:${flower.nombre} descripcion ${flower.descripcion}: precio: ${flower.precio} stock: ${flower.stock} ");
    }
    double heightScreen = MediaQuery.of(context).size.width;
    print(heightScreen / 4);
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Image.asset(
            'assets/images/Happy-Mothers-Day-mobil.jpg',
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
                Navigator.pushNamed(context, '/LoginScreen');
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
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.91),
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
                    Navigator.pushNamed(context, '/RegisterScreen');
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
                context.read<UserProvider>().setDataUser(
                    telefono: '*****',
                    tipo_usuario: 'Cliente',
                    nombre: "No has iniciado sesión",
                    correo_electronico: "¿Tienes cuenta?",
                    foto: "");

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
