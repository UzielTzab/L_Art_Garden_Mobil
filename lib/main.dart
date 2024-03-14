import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/Screens/loginScreen.dart';
import 'package:l_art_garden_mobil/Screens/mainStore.dart';
import 'package:l_art_garden_mobil/Screens/register.dart';
import 'package:l_art_garden_mobil/Screens/welcome.dart';
import 'package:l_art_garden_mobil/Services/service_product.dart';
import 'package:l_art_garden_mobil/model_provider/cartListProvider.dart';
import 'package:l_art_garden_mobil/model_provider/cart_provider.dart';
import 'package:l_art_garden_mobil/model_provider/counter_cart.dart';
import 'package:l_art_garden_mobil/model_provider/products_test_provider.dart';
import 'package:l_art_garden_mobil/model_provider/users.dart';
import 'package:provider/provider.dart';
import './model_provider/favorites_provider.dart';
import './model_provider/products_test_provider.dart';
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
    getAllProducts();

    // getUserByEmailAndPassword("u", "u");
    // getOneUser(45);
    // getAllUsers();
    // createUser(User(
    //     id: 0, // No importa el ID, ya que se asignará automáticamente en el servidor
    //     nombre: 'Uziel Tzab',
    //     fechaNacimiento: '2004-01-13',
    //     telefono: '555-1234',
    //     correo: 'uzieltzab@gmail.com',
    //     contrasena: '225699',
    //     genero: 'M',
    //     tipoUsuario: 'Vendedor',
    //     foto: null));
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

    // patchUser(2, {
    //   'nombre': 'Uziel Alejandro Tzab Puc',
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CartListProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => FavoritesProvide()),
          ChangeNotifierProvider(create: (_) => CounterCartProvider()),
          ChangeNotifierProvider(create: (_) => ProductsTestProvider()),
        ],
        builder: (context, _) {
          return MaterialApp(
            initialRoute: '/',
            routes: {
              '/': (context) => const Welcome(),
              '/MainStore': (context) => const MainStore(),
              '/LoginScreen': (context) => const LoginScreen(),
              '/RegisterScreen': (context) => const registerScreen(),
            },
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
                    seedColor: Color.fromARGB(255, 241, 221, 167)),
                useMaterial3: true),
            color: const Color.fromARGB(255, 237, 145, 88),
            debugShowCheckedModeBanner: false,
            title: 'L Art Garden',
          );
        });
  }
}
