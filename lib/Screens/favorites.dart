import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/AnimationRoutes/routeAnimatedBottomToTop.dart';
import 'package:l_art_garden_mobil/model_provider/products_provider.dart';
import '../model_provider/favorites_provider.dart';
import 'product_screee.dart';

import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldExample();
  }
}

class ScaffoldExample extends StatefulWidget {
  const ScaffoldExample({super.key});

  @override
  State<ScaffoldExample> createState() => _ScaffoldExampleState();
}

class _ScaffoldExampleState extends State<ScaffoldExample> {
  static const Color orangeColor = const Color.fromARGB(255, 209, 137, 49);
  static const Color baseColor = Color.fromARGB(255, 242, 173, 83);
  static const Color baseColorDark = Color.fromARGB(255, 163, 114, 49);
  static const Color unselectColor = Color.fromARGB(255, 107, 77, 12);
  static const Color disableColor = Color.fromARGB(255, 193, 193, 193);

  int CounterElementsInMyList = 0;
  @override
  Widget build(BuildContext context) {
    FavoritesProvider watchFavoritesProvide =
        context.watch<FavoritesProvider>();
    ProductProvider watchProductsProvider = context.watch<ProductProvider>();

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              const Icon(
                Icons.favorite,
                color: baseColorDark,
              ),
              const Text(
                'Favoritos',
                style: TextStyle(color: baseColorDark, fontFamily: "Capri"),
              ),
            ],
          ),
        ),
        body: watchFavoritesProvide.favoriteProducts.isNotEmpty
            ? ListView.builder(
                itemCount: watchFavoritesProvide.favoriteProducts.length,
                itemBuilder: (BuildContext context, int index) {
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
                              const Icon(
                                Icons.monetization_on,
                                color: orangeColor,
                              ),
                              Text(
                                watchFavoritesProvide
                                    .favoriteProducts[index].precio
                                    .toString(),
                                style: const TextStyle(
                                    fontFamily: "Capri", color: orangeColor),
                              ),
                            ],
                          ),
                          leading: Image.network(
                              '${watchFavoritesProvide.favoriteProducts[index].imagen5}'),
                          onTap: () {
                            int temporalId = watchFavoritesProvide
                                .favoriteProducts[index].idProducto;
                            int indexTestProduct = watchProductsProvider
                                .products
                                .indexWhere((product) =>
                                    product.idProducto == temporalId);

                            if (indexTestProduct != -1) {
                              Navigator.of(context).push(
                                  PageRoutesFree.createPageRoute(ProductScreen(
                                      watchFavoritesProvide
                                          .favoriteProducts[index]
                                          .idProducto)));
                            } else {
                              print(
                                  'Producto no encontrado en la lista de productos');
                            }
                          },
                          trailing: IconButton(
                            color: baseColorDark,
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
