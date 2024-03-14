import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/Screens/cartMain.dart';
import 'package:l_art_garden_mobil/Widgets/classicButton.dart';
import 'package:l_art_garden_mobil/model_provider/cartListProvider.dart';
import 'package:l_art_garden_mobil/model_provider/cart_provider.dart';
import 'package:l_art_garden_mobil/model_provider/counter_cart.dart';
import 'package:l_art_garden_mobil/model_provider/favorites_provider.dart';
import 'package:l_art_garden_mobil/model_provider/products_test_provider.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  final int index;
  const ProductScreen(this.index, {super.key});

  @override
  State<ProductScreen> createState() => _YourNewScreenState();
}

class _YourNewScreenState extends State<ProductScreen> {
  Color baseColor = Colors.amber;

  int productCount = 0;
  bool isPressedFavorite = false;
  bool isPressedAddCart = false;

  @override
  Widget build(BuildContext context) {
    CounterCartProvider watchCounterProvider =
        context.watch<CounterCartProvider>();

    ProductsTestProvider watchProductsTestProvider =
        context.watch<ProductsTestProvider>();
    FavoritesProvide watchFlowerProvider = context.watch<FavoritesProvide>();
    CartListProvider watchListCartProvider = context.watch<CartListProvider>();
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
              if (watchCounterProvider.counter > 0)
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
                      minWidth: 15,
                      minHeight: 15,
                    ),
                    child: Text(
                      '${watchCounterProvider.counter}',
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
                const Icon(Icons.image),
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
                              .flores[widget.index].idProducto,
                          imageUrl: "",
                          descripcion: watchProductsTestProvider
                              .flores[widget.index].descripcion,
                          precio: watchProductsTestProvider
                              .flores[widget.index].precio);
                      final snackBar = SnackBar(
                        duration: const Duration(seconds: 1),
                        backgroundColor: Color.fromARGB(255, 52, 156, 3),
                        content:
                            const Text('¡Agregaste correctamente a favoritos!'),
                        action: SnackBarAction(
                          textColor: Colors.white,
                          label: 'Omitir',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      context
                          .read<FavoritesProvide>()
                          .removeFlower(widget.index);
                      final sanckBar = SnackBar(
                        duration: const Duration(seconds: 1),
                        backgroundColor: const Color.fromARGB(255, 224, 35, 6),
                        content: const Text(
                            'Quitaste este producto de tus favoritos'),
                        action: SnackBarAction(
                            textColor: Colors.white,
                            label: 'Omitir',
                            onPressed: () {}),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(sanckBar);
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
                      // child: CalssicButton(
                      //     counterCartProvider: watchCounterProvider.counter,
                      //     wacthProductTestProvider: watchProductsTestProvider,
                      //     widgetIndex: widget.index,
                      //     widgetContext: context,
                      //     typeOperation: 1),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 235, 161, 65))),
                        onPressed: () {
                          setState(() {
                            context.read<CounterCartProvider>().setDataCounter(
                                counter: watchCounterProvider.counter + 1);
                          });

                          context.read<CartListProvider>().addFlowerToCart(
                              indexFlower: watchProductsTestProvider
                                  .flores[widget.index].idProducto,
                              imageUrl: "",
                              description: watchProductsTestProvider
                                  .flores[widget.index].descripcion,
                              price: watchProductsTestProvider
                                  .flores[widget.index].precio,
                              type: ""
                              // watchProductsTestProvider
                              //     .flores[widget.index].tipo!,
                              ,
                              quantityToBuy: 1);
                          print(
                              "+++++++++++++++Aqui la lista del carrito+++++++++++++++++");
                          for (var flower in watchListCartProvider.flowers) {
                            print(
                                'Id: ${flower.indexFlower},   despcripcion: ${flower.description},    precio: ${flower.price}  CantidadAñadido: ${flower.quantityToBuy}');
                          }

                          print(
                              "++++++++++++++++++LA CANTIDAD AÑADIDAD DE ESE MISMO PRODUCTO++++++++++++++++++");
                          print(watchListCartProvider
                                  .getQuantityByIndex(widget.index) +
                              1);
                          // print(watchListCartProvider
                          //     .flowers[widget.index].quantityToBuy);

                          final snackBar = SnackBar(
                            duration: const Duration(seconds: 1),
                            backgroundColor:
                                const Color.fromARGB(255, 224, 169, 6),
                            content: const Text(
                                '¡Agregaste este producto al carrito!'),
                            action: SnackBarAction(
                              label: 'Omitir',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Agregar al carrito',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 244, 244, 244),
                                  fontFamily: "Capri"),
                            ),
                            Icon(
                              Icons.add_shopping_cart,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ],
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
