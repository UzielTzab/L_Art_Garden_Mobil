import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/Screens/cart_main.dart';
import 'package:l_art_garden_mobil/model_provider/cart_provider.dart';
import 'package:l_art_garden_mobil/model_provider/counter_cart.dart';
import 'package:l_art_garden_mobil/model_provider/favorites_provider.dart';
import 'package:l_art_garden_mobil/model_provider/products_test_provider.dart';
import 'package:provider/provider.dart';
import 'ClaseIntermediaria.dart';

class YourNewScreen extends StatefulWidget {
  final List<String> imageUrls;
  final int index;
  const YourNewScreen(this.imageUrls, this.index, {super.key});

  @override
  State<YourNewScreen> createState() => _YourNewScreenState();
}

class _YourNewScreenState extends State<YourNewScreen> {
  Color baseColor = Colors.amber;

  final CartIndexList _cartIndexList =
      CartIndexList(); // Instancia de CartIndexList

  int productCount = 0;
  bool isPressedFavorite = false;
  bool isPressedAddCart = false;

  @override
  Widget build(BuildContext context) {
    ProductsTestProvider watchProductProvider =
        context.watch<ProductsTestProvider>();
    CounterCartProvider watchCounterProvider =
        context.watch<CounterCartProvider>();
    productCount = watchCounterProvider.counter;
    print(productCount);
    ProductsTestProvider watchProductsTestProvider =
        context.watch<ProductsTestProvider>();
    FavoritesProvide watchFlowerProvider = context.watch<FavoritesProvide>();
    CartProvider watchCartProvider = context.watch<CartProvider>();
    if (watchFlowerProvider.findFlower(widget.index)) {
      isPressedFavorite = true;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 242, 173, 83),
        title: const Text("Producto"),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const CartMain())));
                },
                icon: const Icon(
                  Icons.shopping_bag,
                  size: 20,
                ),
              ),
              if (productCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 226, 189, 53),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$productCount',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.network(widget.imageUrls[widget.index]),
                IconButton.outlined(
                  icon: isPressedFavorite
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite_outline_rounded),
                  onPressed: () {
                    setState(() {
                      isPressedFavorite = !isPressedFavorite;
                    });

                    if (isPressedFavorite) {
                      context.read<FavoritesProvide>().addFlower(
                          indexFlower: watchProductsTestProvider
                              .flores[widget.index].indexFlower,
                          imageUrl: watchProductsTestProvider
                              .flores[widget.index].imageUrl,
                          descripcion: watchProductsTestProvider
                              .flores[widget.index].descripcion,
                          precio: watchProductsTestProvider
                              .flores[widget.index].precio);
                    } else {
                      context
                          .read<FavoritesProvide>()
                          .removeFlower(widget.index);
                    }
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(children: [
                    Text(
                        watchProductsTestProvider
                            .flores[widget.index].descripcion,
                        style: const TextStyle(fontSize: 38)),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: Text(
                          watchProductsTestProvider
                              .flores[widget.index].descripcion,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(146, 255, 255, 255),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.local_florist_rounded,
                                ),
                                Text(
                                  watchProductsTestProvider
                                      .flores[widget.index].tipo
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.monetization_on_rounded,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                                Text(
                                  watchProductsTestProvider
                                      .flores[widget.index].precio
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    //Boton de agregar al carrito
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white)),
                        onPressed: () {
                          setState(() {
                            isPressedAddCart = !isPressedAddCart;
                            _cartIndexList.addIndex(widget.index);
                            context.read<CounterCartProvider>().setDataCounter(
                                counter: watchCounterProvider.counter +
                                    1); // Agregar el índice al carrito
                          });

                          if (isPressedAddCart) {
                            context.read<CartProvider>().addFlower(
                                indexFlower: widget.index,
                                imageUrl: widget.imageUrls[widget.index],
                                descripcion: watchProductsTestProvider
                                    .flores[widget.index].descripcion,
                                precio: watchProductsTestProvider
                                    .flores[widget.index].precio);
                            // for (var flowers in watchCartProvider.flores) {
                            //   print(
                            //       'id: ${flowers.indexFlower} despcripcion: ${flowers.descripcion}  imagenUrl: ${flowers.imageUrl}  precio: ${flowers.precio}');
                            // }
                            // print(
                            //     'Añadiste la flor con indice: ${watchFlowerProvider.findFlowerByIndex(widget.index)}');

                            // for (var flowers in watchCartProvider.flores) {
                            //   print(
                            //       'id: ${flowers.indexFlower} despcripcion: ${flowers.descripcion}  imagenUrl: ${flowers.imageUrl}  precio: ${flowers.precio}');
                            // }
                            final snackBar = SnackBar(
                              backgroundColor:
                                  const Color.fromARGB(255, 224, 169, 6),
                              content: const Text(
                                  '¡Agregaste correctamente este producto!'),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            print(
                                'Removiste la flor con indice: ${watchCartProvider.findFlowerByIndex(widget.index)}');
                            context
                                .read<FavoritesProvide>()
                                .removeFlower(widget.index);
                            for (var flowers in watchCartProvider.flores) {
                              print(
                                  'id: ${flowers.indexFlower} despcripcion: ${flowers.descripcion}  imagenUrl: ${flowers.imageUrl}  precio: ${flowers.precio}');
                            }
                          }
                        },
                        child: Text(
                          'Agregar al carrito',
                          style: TextStyle(
                              fontSize: 20,
                              color: baseColor,
                              fontFamily: "Capri"),
                        ),
                      ),
                    )
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
