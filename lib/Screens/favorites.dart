import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/AnimationRoutes/routeAnimatedBottomToTop.dart';
import 'package:l_art_garden_mobil/model_provider/products_test_provider.dart';
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
    FavoritesProvide watchFavoritesProvide = context.watch<FavoritesProvide>();
    ProductsTestProvider wtachProductsTestProvider =
        context.watch<ProductsTestProvider>();

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Favoritos',
            style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0), fontFamily: "Capri"),
          ),
        ),
        body: watchFavoritesProvide.flores.isNotEmpty
            ? ListView.builder(
                itemCount: watchFavoritesProvide.flores.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 0,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            watchFavoritesProvide.flores[index].descripcion,
                            style: const TextStyle(fontFamily: "Capri"),
                          ),
                          subtitle: Row(
                            children: [
                              const Icon(Icons.monetization_on),
                              Text(
                                watchFavoritesProvide.flores[index].precio
                                    .toString(),
                                style: const TextStyle(fontFamily: "Capri"),
                              ),
                            ],
                          ),
                          leading: Image.network(
                              watchFavoritesProvide.flores[index].imageUrl),
                          onTap: () {
                            int temporalIndex =
                                watchFavoritesProvide.flores[index].indexFlower;
                            int indexTestProduct = wtachProductsTestProvider
                                .flores[temporalIndex].indexFlower;
                            print(
                                'Esto es el numero del index en la nueva pantalla: $index');
                            Navigator.of(context).push(
                                PageRoutes.createPageRoute(indexTestProduct));

                            // Acción cuando se toca la carta
                          },
                          trailing: IconButton(
                            color: const Color.fromARGB(255, 150, 118, 20),
                            onPressed: () {
                              int? temporalIndex = watchFavoritesProvide
                                  .flores[index].indexFlower;
                              // print('Esto es index $temporalIndex');
                              // print("-------Lista de flores en el favoritos--------");
                              // for (var flor in watchFlowerProvider.flores) {
                              //   print(
                              //       'id de la flor: ${flor.indexFlower},    Descripcion de la flor: ${flor.descripcion}');
                              // }
                              // print('----------------------------------------------');
                              // print(
                              //     "has eliminado el producto del favoritos con el indice: ${watchFlowerProvider.flores[index].indexFlower}");
                              watchFavoritesProvide.removeFlower(temporalIndex);
                              // print(
                              //     "-------Lista de flores en el favoritos despues de eliminar--------");
                              // for (var flor in watchFlowerProvider.flores) {
                              //   print(
                              //       'id de la flor: ${flor.indexFlower},    Descripcion de la flor: ${flor.descripcion}');
                              // }
                              // print('----------------------------------------------');
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
