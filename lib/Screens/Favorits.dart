import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/model_provider/flower_product_provider.dart';
import 'package:l_art_garden_mobil/model_provider/products_test_provider.dart';
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
  @override
  Widget build(BuildContext context) {
    FlowerProvider watchFlowerProvider = context.watch<FlowerProvider>();
    ProductsTestProvider watchProductProvider =
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
      body: ListView.builder(
        itemCount: watchFlowerProvider.flores.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 0,
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    watchFlowerProvider.flores[index].descripcion,
                    style: const TextStyle(fontFamily: "Capri"),
                  ),
                  subtitle: Row(
                    children: [
                      const Icon(Icons.monetization_on),
                      Text(
                        watchFlowerProvider.flores[index].precio.toString(),
                        style: const TextStyle(fontFamily: "Capri"),
                      ),
                    ],
                  ),
                  leading:
                      Image.network(watchFlowerProvider.flores[index].imageUrl),
                  onTap: () {
                    // Acción cuando se toca la carta
                  },
                  trailing: IconButton(
                    color: const Color.fromARGB(255, 150, 118, 20),
                    onPressed: () {
                      setState(() {
                        int? temporalIndex =
                            watchFlowerProvider.flores[index].indexFlower;
                        print('Esto es index $temporalIndex');
                        print("-------Lista de flores en el favoritos--------");
                        for (var flor in watchFlowerProvider.flores) {
                          print(
                              'id de la flor: ${flor.indexFlower},    Descripcion de la flor: ${flor.descripcion}');
                        }
                        print('----------------------------------------------');
                        print(
                            "has eliminado el producto del favoritos con el indice: ${watchFlowerProvider.flores[index].indexFlower}");
                        watchFlowerProvider.removeFlower(temporalIndex);
                        print(
                            "-------Lista de flores en el favoritos despues de eliminar--------");
                        for (var flor in watchFlowerProvider.flores) {
                          print(
                              'id de la flor: ${flor.indexFlower},    Descripcion de la flor: ${flor.descripcion}');
                        }
                        print('----------------------------------------------');
                      });
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
      ),
    );
  }
}
