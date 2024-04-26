import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:l_art_garden_mobil/AnimationRoutes/routeAnimatedBottomToTop.dart';
import 'package:l_art_garden_mobil/Models/user.dart';
import 'package:l_art_garden_mobil/Screens/bought_products_screen.dart';
import 'package:l_art_garden_mobil/Screens/data_user_screen.dart';
import 'package:l_art_garden_mobil/Screens/notifications.dart';
import 'package:l_art_garden_mobil/Services/google_maps.dart';
import 'package:l_art_garden_mobil/Widgets/waiting_load.dart';
import 'package:l_art_garden_mobil/model_provider/adress_provider.dart';
import 'package:l_art_garden_mobil/model_provider/counter_cart.dart';
import 'package:l_art_garden_mobil/model_provider/users_provider.dart';
import 'package:provider/provider.dart';
import 'flower_main.dart';
import 'cart_main.dart';
import 'favorites.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class MainStore extends StatefulWidget {
  const MainStore({super.key});

  @override
  State<MainStore> createState() => _MainStoreState();
}

class _MainStoreState extends State<MainStore> {
  static const Color baseColor = Color.fromARGB(255, 242, 173, 83);
  static const Color baseColorDark = Color.fromARGB(255, 163, 114, 49);
  static const Color unselectColor = Color.fromARGB(255, 107, 77, 12);
  static const Color disableColor = Color.fromARGB(255, 193, 193, 193);
  int selectedIndex = 0;

  final List<Widget> _sectionsToGlobalStore = <Widget>[
    const FlowerMain(),
    const FavoritesScreen(),
    const CartMain(),
    const NotificationsScreen(),
  ];

  void _itemOnTaped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void initState() {
    super.initState();
    loadAndShowLocation();
  }

  Future<void> loadAndShowLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      ShowLocationDialogGoogleMaps(context, position);
    } catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Ubicación desactivada'),
            content: Text(
                'Puedes activar la ubicación más tarde en la configuración de tu dispositivo.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider watchUser = context.watch<UserProvider>();
    CounterCartProvider watchCounterPorvider =
        context.watch<CounterCartProvider>();
    AddressProvider watchAddressProvider = context.watch<AddressProvider>();

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: unselectColor),
        elevation: 0,
        title: Center(
          child: Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0),
            child: const Text(
              'L-ART GARDEN',
              style: TextStyle(
                  fontFamily: 'Capri',
                  fontSize: 18,
                  color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
        ),
        actions: [
          Flexible(
            child: Text(
              watchAddressProvider.street != ""
                  ? '${watchAddressProvider.street}, ${watchAddressProvider.postalCode}'
                  : '',
              style: TextStyle(fontSize: 13, color: unselectColor),
            ),
          ),
          Stack(children: [
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 0),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CartMain()));
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  color: unselectColor,
                  size: 20,
                ),
              ),
            ),
            if (watchCounterPorvider.counter > 0)
              Positioned(
                  top: MediaQuery.of(context).size.width * 0.01,
                  right: 1,
                  left: 1,
                  child: Container(
                      constraints: const BoxConstraints(
                        maxWidth: 15,
                        minHeight: 15,
                      ),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(0, 238, 205, 106),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        '${watchCounterPorvider.counter}',
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      )))
          ])
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                baseColor,
                baseColor
                // Opacidad ajustable
              ],
            ),
          ),
        ),
      ),
      body: _sectionsToGlobalStore.elementAt(selectedIndex),
      drawer: Drawer(
          width: MediaQuery.of(context).size.width * 0.7,
          child: watchUser.user.nombre != ""
              ? ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    UserAccountsDrawerHeader(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 241, 165, 65),
                            Color.fromARGB(255, 241, 165, 65),
                          ],
                        ),
                      ),
                      accountName: Text(
                        watchUser.user.nombre,
                        style: const TextStyle(
                          fontSize: 23,
                          fontFamily: 'CuteFlower',
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      accountEmail: Text(
                        watchUser.user.correo,
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'CuteFlower',
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        child: ClipOval(
                          child: watchUser.user.foto != '' &&
                                  watchUser.user.foto!.isEmpty
                              ? Image.network(
                                  'https://api-mysql-types-l-art-garden.onrender.com/api/userImage/${watchUser.user.foto}',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.account_box),
                        ), // Aquí se corrige la línea
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.dashboard_outlined,
                        color: baseColorDark,
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                            PageRoutesFree.createPageRoute(
                                const DataUserScreen()));
                      },
                      title: const Text(
                        "Mis datos personales",
                        style: TextStyle(fontSize: 15, color: baseColorDark),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.shopping_bag_outlined,
                        color: baseColorDark,
                      ),
                      title: Text(
                        "Mis compras",
                        style: TextStyle(fontSize: 15, color: baseColorDark),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BoughtProductsScreen(),
                          ),
                        );
                      },
                    ),
                    const ListTile(
                      leading: Icon(
                        Icons.repeat_rounded,
                        color: baseColorDark,
                      ),
                      title: Text(
                        'Mis devoluciones',
                        style: TextStyle(
                          fontSize: 15,
                          color: baseColorDark,
                        ),
                      ),
                    ),
                    const ListTile(
                      leading: Icon(
                        Icons.cancel,
                        color: baseColorDark,
                      ),
                      title: Text(
                        'Mis cancelaciones',
                        style: TextStyle(fontSize: 15, color: baseColorDark),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Cerrar sesión',
                            style: TextStyle(color: baseColorDark),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.logout_outlined,
                              color: baseColorDark,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Row(
                                    children: [
                                      Icon(
                                        Icons.logout_outlined,
                                        color: unselectColor,
                                      ),
                                      Text('Cerrar sesión'),
                                    ],
                                  ),
                                  content: Text(
                                      '¿Estás seguro de que quieres cerrar la sesión?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Cancelar'),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Cierra el diálogo
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Aceptar'),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Cierra el diálogo
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => WaitingPage(
                                              message:
                                                  'Nos vemos pronto ${watchUser.user.nombre}',
                                              onWaitComplete: () {
                                                context
                                                    .read<UserProvider>()
                                                    .setUser(
                                                      UserModel(
                                                        id: 0,
                                                        nombre: "",
                                                        correo: "",
                                                        telefono: "",
                                                        contrasenia: "",
                                                        fechaNacimiento: "",
                                                        genero: "",
                                                        tipoUsuario: 0,
                                                        foto: "",
                                                        latitud: 0,
                                                        longitud: 0,
                                                        direccion1: "",
                                                        direccion2: "",
                                                        direccion3: "",
                                                      ),
                                                    );
                                                // Navega a la siguiente pantalla después de completar la espera
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MainStore(),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                )
              : ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    UserAccountsDrawerHeader(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 241, 165, 65),
                            Color.fromARGB(255, 241, 165, 65),
                          ],
                        ),
                      ),
                      accountName: Text(
                        watchUser.user.nombre,
                        style: const TextStyle(
                          fontSize: 23,
                          fontFamily: 'CuteFlower',
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      accountEmail: const Text(
                        'Toca el avatar para iniciar',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'CuteFlower',
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      currentAccountPicture: GestureDetector(
                        onTap: () =>
                            {Navigator.pushNamed(context, '/RegisterScreen')},
                        child: const CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          child: ClipOval(
                            child: Icon(Icons.account_box),
                          ), // Aquí se corrige la línea
                        ),
                      ),
                    ),
                    const ListTile(
                      title: Text(
                        "Mis datos personales",
                        style: TextStyle(fontSize: 15, color: disableColor),
                      ),
                    ),
                    const ListTile(
                        title: Text(
                      "Mis compras",
                      style: TextStyle(fontSize: 15, color: disableColor),
                    )),
                    const ListTile(
                      title: Text(
                        'Mis devoluciones',
                        style: TextStyle(
                          fontSize: 15,
                          color: disableColor,
                        ),
                      ),
                    ),
                    const ListTile(
                      title: Text(
                        'Mis cancelaciones',
                        style: TextStyle(fontSize: 15, color: disableColor),
                      ),
                    ),
                  ],
                )),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 14,
        unselectedFontSize: 13,
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        iconSize: MediaQuery.of(context).size.height / 23,
        showUnselectedLabels: true,
        unselectedItemColor: const Color.fromARGB(255, 192, 163, 99),
        selectedItemColor: baseColor,
        currentIndex: selectedIndex,
        onTap: _itemOnTaped,
        selectedIconTheme:
            const IconThemeData(color: Color.fromARGB(255, 241, 185, 65)),
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.store), label: 'Inicio', tooltip: 'Inicio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favoritos',
              tooltip: 'favoritos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Carrito',
              tooltip: 'Carrito'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: "Notificaciones",
              tooltip: 'Notificaciones')
        ],
      ),
    );
  }
}
