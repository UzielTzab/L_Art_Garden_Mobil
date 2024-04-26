import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/AnimationRoutes/routeAnimatedBottomToTop.dart';
import 'package:l_art_garden_mobil/model_provider/products_provider.dart';
import '../model_provider/favorites_provider.dart';

import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Favorites',
      home: ScaffoldExample(),
    );
  }
}

class ScaffoldExample extends StatefulWidget {
  const ScaffoldExample({super.key});

  @override
  State<ScaffoldExample> createState() => _ScaffoldExampleState();
}

class _ScaffoldExampleState extends State<ScaffoldExample> {
  int CounterElementsInMyList = 0;
  @override
  Widget build(BuildContext context) {
    FavoritesProvider watchFavoritesProvide =
        context.watch<FavoritesProvider>();
    ProductProvider watchProductsProvider = context.watch<ProductProvider>();
    BuildContext contextFatter = context;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              const Icon(
                Icons.favorite,
                color: Color.fromARGB(255, 98, 84, 52),
              ),
              const Text(
                'Favoritos',
                style: TextStyle(
                    color: Color.fromARGB(255, 98, 84, 52),
                    fontFamily: "Capri"),
              ),
            ],
          ),
        ),
        body: watchFavoritesProvide.favoriteProducts.isNotEmpty
            ? ListView.builder(
                itemCount: watchFavoritesProvide.favoriteProducts.length,
                itemBuilder: (_, int index) {
                  return Card(
                    elevation: 0,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            watchFavoritesProvide
                                .favoriteProducts[index].descripcion,
                            style: const TextStyle(fontFamily: "Capri"),
                          ),
                          subtitle: Row(
                            children: [
                              const Icon(Icons.monetization_on),
                              Text(
                                watchFavoritesProvide
                                    .favoriteProducts[index].precio
                                    .toString(),
                                style: const TextStyle(fontFamily: "Capri"),
                              ),
                            ],
                          ),
                          leading: Image.network(
                              'https://floresfinas.oss-us-east-1.aliyuncs.com/mj-v1/arreglo-floral-m4067-1.webp'),
                          onTap: () {
                            int temporalId = watchFavoritesProvide
                                .favoriteProducts[index].idProducto;
                            int indexTestProduct = watchProductsProvider
                                .products
                                .indexWhere((product) =>
                                    product.idProducto == temporalId);

                            print('Esto es el indice del listBuild: $index');
                            print('Temporal index: ${temporalId}');
                            print(
                                'Abriendo pantalla con detalles de producto con el indice: $indexTestProduct');

                            if (indexTestProduct != -1) {
                              Navigator.of(context).push(
                                  PageRoutes.createPageRoute(indexTestProduct));
                            } else {
                              print(
                                  'Producto no encontrado en la lista de productos');
                            }
                          },
                          trailing: IconButton(
                            color: const Color.fromARGB(255, 150, 118, 20),
                            onPressed: () {
                              int? temporalIndex = watchFavoritesProvide
                                  .favoriteProducts[index].idProducto;
                              watchFavoritesProvide
                                  .removeProduct(temporalIndex);
                              final sanckBar = SnackBar(
                                backgroundColor:
                                    const Color.fromARGB(255, 224, 35, 6),
                                content: const Text(
                                    'Quitaste este producto de tus favoritos'),
                                action: SnackBarAction(
                                    textColor: Colors.white,
                                    label: 'Omitir',
                                    onPressed: () {}),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(sanckBar);
                            },
                            icon: const Icon(Icons.heart_broken_outlined),
                          ),
                        ),
                        const Divider(
                          // Agregar un Divider entre cada ListTile
                          color: Colors.grey, // Color del separador
                          thickness: 1, // Grosor del separador
                        ),
                      ],
                    ),
                  );
                },
              )
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Aun no has agregado productos a tus favoritos',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Capri",
                        color: Color.fromARGB(255, 150, 150, 150)),
                  ),
                  Icon(
                    Icons.favorite,
                    color: Color.fromARGB(255, 196, 196, 196),
                  ),
                ],
              ));
  }
}
