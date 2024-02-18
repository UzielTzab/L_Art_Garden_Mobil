import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 192, 163, 99)),
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
                  color: const Color.fromARGB(255, 241, 185, 65)),
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
                color: Color.fromARGB(255, 192, 163, 99),
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
                Color.fromARGB(255, 255, 253, 249),
                Color.fromARGB(255, 255, 255, 255),
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
          children: const [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 241, 185, 65),
                    Color.fromARGB(255, 241, 185, 65),
                  ],
                ),
              ),
              accountName: Text(
                'Uziel Tzab',
                style: TextStyle(
                    fontSize: 23,
                    fontFamily: 'CuteFlower',
                    color: Color.fromARGB(255, 255, 255, 255)),
              ),
              accountEmail: Text(
                'uzieltzab8@gmail.com',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'CuteFlower',
                    color: Color.fromARGB(255, 255, 255, 255)),
              ),
              currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/usuario.png'),
                  backgroundColor: Color.fromARGB(255, 255, 255, 255)),
            ),
            ListTile(
              title: Text(
                "Mi perfil",
                style: TextStyle(
                    fontSize: 17, color: Color.fromARGB(255, 241, 185, 65)),
              ),
            ),
            ListTile(
                title: Text(
              "Mis compras",
              style: TextStyle(
                  fontSize: 17, color: Color.fromARGB(255, 176, 119, 88)),
            )),
            ListTile(
              title: Text(
                'Vender',
                style: TextStyle(
                  fontSize: 17,
                  color: Color.fromARGB(255, 176, 119, 88),
                ),
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
        iconSize: MediaQuery.of(context).size.height / 18,
        showUnselectedLabels: true,
        unselectedItemColor: Color.fromARGB(255, 192, 163, 99),
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
