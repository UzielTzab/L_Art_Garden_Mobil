import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/Screens/notifications.dart';
import 'package:l_art_garden_mobil/model_provider/counter_cart.dart';
import 'package:l_art_garden_mobil/model_provider/users.dart';
import 'package:provider/provider.dart';
import 'flowerMain.dart';
import 'cartMain.dart';
import 'favorites.dart';
import 'dart:convert';

class MainStore extends StatefulWidget {
  const MainStore({super.key});

  @override
  State<MainStore> createState() => _MainStoreState();
}

class _MainStoreState extends State<MainStore> {
  static const Color baseColor = Color.fromARGB(255, 242, 173, 83);
  static const Color baseColorDark = Color.fromARGB(255, 163, 114, 49);
  static const Color unselectColor = Color.fromARGB(255, 107, 77, 12);
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

  @override
  Widget build(BuildContext context) {
    UserProvider watchUser = context.watch<UserProvider>();
    CounterCartProvider watchCounterPorvider =
        context.watch<CounterCartProvider>();

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: unselectColor),
        elevation: 0,
        title: Center(
          child: Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width / 50),
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
                  Icons.shopping_bag,
                  color: unselectColor,
                  size: 20,
                ),
              ),
            ),
            if (watchCounterPorvider.counter > 0)
              Positioned(
                  top: MediaQuery.of(context).size.width * 0.02,
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
        width: MediaQuery.of(context).size.width * 0.6,
        child: ListView(
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
                watchUser.nombre,
                style: const TextStyle(
                  fontSize: 23,
                  fontFamily: 'CuteFlower',
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              accountEmail: Text(
                watchUser.correo_electronico,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'CuteFlower',
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                child: ClipOval(
                  child: watchUser.foto != null && watchUser.foto!.isNotEmpty
                      ? Image.memory(
                          base64Decode(watchUser.foto!),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : Image.asset('assets/images/usuario.png'),
                ), // Aquí se corrige la línea
              ),
            ),
            ListTile(
              onTap: () {},
              title: const Text(
                "Mis datos personales",
                style: TextStyle(fontSize: 15, color: baseColorDark),
              ),
            ),
            const ListTile(
                title: Text(
              "Mis compras",
              style: TextStyle(fontSize: 15, color: baseColorDark),
            )),
            const ListTile(
              title: Text(
                'Mis devoluciones',
                style: TextStyle(
                  fontSize: 15,
                  color: baseColorDark,
                ),
              ),
            ),
            const ListTile(
              title: Text(
                'Mis cancelaciones',
                style: TextStyle(fontSize: 15, color: baseColorDark),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 14,
        unselectedFontSize: 13,
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        iconSize: MediaQuery.of(context).size.height / 23,
        showUnselectedLabels: true,
        unselectedItemColor: const Color.fromARGB(255, 192, 163, 99),
        selectedItemColor: const Color.fromARGB(255, 241, 185, 65),
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
