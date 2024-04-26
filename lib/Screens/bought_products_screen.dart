import 'package:flutter/material.dart';

class Product {
  final String name;
  final IconData icon;
  final String florist;

  Product({required this.name, required this.icon, required this.florist});
}

class BoughtProductsScreen extends StatelessWidget {
  final List<Product> products = [
    Product(
        name: 'Producto 1',
        icon: Icons.shopping_bag_outlined,
        florist: 'Florería 1'),
    Product(
        name: 'Producto 2',
        icon: Icons.shopping_bag_outlined,
        florist: 'Florería 1'),
    Product(
        name: 'Producto 3',
        icon: Icons.shopping_bag_outlined,
        florist: 'Florería 2'),
    // Agrega más productos aquí
  ];

  static const Color baseColor = Color.fromARGB(255, 242, 173, 83);
  static const Color baseColorDark = Color.fromARGB(255, 163, 114, 49);
  static const Color unselectColor = Color.fromARGB(255, 107, 77, 12);
  static const Color disableColor = Color.fromARGB(255, 193, 193, 193);

  @override
  Widget build(BuildContext context) {
    var florists = products.map((product) => product.florist).toSet().toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tus compras',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: baseColor,
      ),
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: AppBar(
              backgroundColor: Colors.white,
              bottom: TabBar(
                unselectedLabelColor: unselectColor,
                indicatorColor: baseColor,
                labelColor: baseColor,
                tabs: [
                  Tab(text: 'Recibidos'),
                  Tab(text: 'En camino'),
                  Tab(text: 'No atendido'),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              buildTabContent(florists),
              buildTabContent(florists),
              buildTabContent(florists),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTabContent(List<String> florists) {
    return ListView.builder(
      itemCount: florists.length,
      itemBuilder: (context, index) {
        var floristProducts = products
            .where((product) => product.florist == florists[index])
            .toList();

        return Card(
          child: ExpansionTile(
            leading: Icon(Icons.shopping_cart_checkout),
            title: Text('Pedido # $index'),
            children: floristProducts.map((product) {
              return ListTile(
                leading: Icon(
                  product.icon,
                  color: baseColorDark,
                ),
                title: Text(
                  product.name,
                  style: TextStyle(fontSize: 15, color: baseColorDark),
                ),
                onTap: () {
                  // Aquí puedes manejar el evento de tap en el ListTile
                  // Por ejemplo, podrías navegar a una nueva pantalla que muestre detalles del producto
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
