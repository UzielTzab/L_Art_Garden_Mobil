import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/model_provider/provider.dart';
import 'package:provider/provider.dart';
import '../Main_Store/FlowersMain.dart';
import '../../CartMain/CartMain.dart';
import 'ClaseIntermediaria.dart';
import '../../Favorits/Favorits.dart';

class MainStore extends StatefulWidget {
  const MainStore({super.key});

  @override
  State<MainStore> createState() => _MainStoreState();
}

class _MainStoreState extends State<MainStore> {
  static const Color baseColor = Color.fromARGB(255, 242, 173, 83);
  static const Color baseColorDark = Color.fromARGB(255, 163, 114, 49);
  static const Color unselectColor = Color.fromARGB(255, 156, 112, 18);
  final CartIndexList _cartIndexList = CartIndexList();
  int selectedIndex = 0;

  final List<Widget> _sectionsToGlobalStore = <Widget>[
    const FlowerMain(),
    const FavoritesScreen(),
    CartMain(indices: CartIndexList().indexUrls),
    const Text("u4")
  ];

  void _itemOnTaped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserProvider watch = context.watch<UserProvider>();
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
          Padding(
            padding: const EdgeInsets.only(left: 0, right: 0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CartMain(
                              indices: [2, 2, 3, 4, 5],
                            )));
              },
              icon: const Icon(
                Icons.shopping_bag,
                color: unselectColor,
              ),
            ),
          ),
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
                watch.nombre,
                style: const TextStyle(
                    fontSize: 23,
                    fontFamily: 'CuteFlower',
                    color: Color.fromARGB(255, 255, 255, 255)),
              ),
              accountEmail: Text(
                watch.correo_electronico,
                style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'CuteFlower',
                    color: Color.fromARGB(255, 255, 255, 255)),
              ),
              currentAccountPicture: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/usuario.png'),
                  backgroundColor: Color.fromARGB(255, 255, 255, 255)),
            ),
            const ListTile(
              title: Text(
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
        selectedFontSize: 15,
        unselectedFontSize: 14,
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        iconSize: MediaQuery.of(context).size.height / 20,
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
