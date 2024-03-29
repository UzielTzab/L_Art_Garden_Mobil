import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/AnimationRoutes/routeAnimatedBottomToTop.dart';
import 'package:l_art_garden_mobil/model_provider/cartListProvider.dart';
import 'package:l_art_garden_mobil/model_provider/counter_cart.dart';

import 'package:l_art_garden_mobil/model_provider/products_test_provider.dart';
import 'package:provider/provider.dart';

class CartMain extends StatefulWidget {
  const CartMain({super.key});

  @override
  State<CartMain> createState() => _CartMainState();
}

class _CartMainState extends State<CartMain> {
  late BuildContext _previousContext;
  double _precioTotal = 0;
  int _cantidadProductos = 0;

  @override
  void initState() {
    super.initState();
    _previousContext = context;
  }

  @override
  Widget build(BuildContext context) {
    Color orangeColor = const Color.fromARGB(255, 209, 137, 49);
    CounterCartProvider wacthConterCartProvider =
        context.watch<CounterCartProvider>();
    CartListProvider watchCartListProvider = context.watch<CartListProvider>();
    ProductsTestProvider watchProductTestProvider =
        context.watch<ProductsTestProvider>();
    for (var flor in watchCartListProvider.flowers) {
      print('id: ${flor.indexFlower}     precio: ${flor.price}');
    }

    calculationPriceAndQuantiy(watchCartListProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Carrito'),
      ),
      body: watchCartListProvider.flowers.isNotEmpty
          ? ListView.builder(
              itemCount: watchCartListProvider.flowers.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 0,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                            watchCartListProvider.flowers[index].description),
                        subtitle: Row(
                          children: [
                            Icon(
                              Icons.monetization_on,
                              color: orangeColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  '${watchCartListProvider.flowers[index].price}',
                                  style: TextStyle(color: orangeColor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Row(
                                    children: [
                                      if (wacthConterCartProvider.counter != 1)
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              calculationPriceAndQuantiy(
                                                  watchCartListProvider);
                                              int temporalIndex =
                                                  watchCartListProvider
                                                      .flowers[index]
                                                      .indexFlower;

                                              _previousContext
                                                  .read<CartListProvider>()
                                                  .removeOneFlower(
                                                      temporalIndex);
                                              calculationPriceAndQuantiy(
                                                  watchCartListProvider);

                                              _previousContext
                                                  .read<CounterCartProvider>()
                                                  .setDataCounter(
                                                      counter:
                                                          _cantidadProductos);
                                            });
                                          },
                                          icon: const Icon(Icons.remove),
                                        )
                                      else
                                        IconButton(
                                          isSelected: true,
                                          onPressed: () {
                                            setState(() {
                                              calculationPriceAndQuantiy(
                                                  watchCartListProvider);
                                              int temporalIndex =
                                                  watchCartListProvider
                                                      .flowers[index]
                                                      .indexFlower;

                                              _previousContext
                                                  .read<CartListProvider>()
                                                  .removeOneFlower(
                                                      temporalIndex);
                                              calculationPriceAndQuantiy(
                                                  watchCartListProvider);

                                              _previousContext
                                                  .read<CounterCartProvider>()
                                                  .setDataCounter(
                                                      counter:
                                                          _cantidadProductos);
                                            });
                                          },
                                          icon: const Icon(Icons.remove),
                                        ),
                                      Text(
                                        watchCartListProvider
                                            .flowers[index].quantityToBuy
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                255, 31, 108, 10)),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              calculationPriceAndQuantiy(
                                                  watchCartListProvider);
                                              int temporalIndex =
                                                  watchCartListProvider
                                                      .flowers[index]
                                                      .indexFlower;

                                              _previousContext
                                                  .read<CartListProvider>()
                                                  .addFlowerToCart(
                                                    indexFlower:
                                                        watchProductTestProvider
                                                            .flores[
                                                                temporalIndex]
                                                            .idProducto,
                                                    quantityToBuy: 1,
                                                    imageUrl: null,
                                                    type: ""
                                                    // watchProductTestProvider
                                                    //     .flores[
                                                    //         temporalIndex]
                                                    //     .tipo!
                                                    ,
                                                    description:
                                                        watchProductTestProvider
                                                            .flores[
                                                                temporalIndex]
                                                            .descripcion,
                                                    price:
                                                        watchProductTestProvider
                                                            .flores[
                                                                temporalIndex]
                                                            .precio,
                                                  );
                                              calculationPriceAndQuantiy(
                                                  watchCartListProvider);

                                              _previousContext
                                                  .read<CounterCartProvider>()
                                                  .setDataCounter(
                                                      counter:
                                                          _cantidadProductos);
                                            });
                                          },
                                          icon: const Icon(Icons.add)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        leading: const Icon(Icons.image),
                        onTap: () {
                          int temporalIndex =
                              watchCartListProvider.flowers[index].indexFlower;
                          int testIndexProduct = watchProductTestProvider
                              .flores[temporalIndex].idProducto;

                          Navigator.of(context).push(
                              PageRoutes.createPageRoute(testIndexProduct));

                          // Acción cuando se toca la carta
                        },
                        trailing: IconButton(
                          color: orangeColor,
                          onPressed: () {
                            setState(() {
                              int temporalIndex = watchCartListProvider
                                  .flowers[index].indexFlower;
                              print(
                                  'Cantidad de productos: $_cantidadProductos');

                              int temporalQuantity = 0;
                              temporalQuantity = watchCartListProvider
                                  .flowers[index].quantityToBuy;

                              watchCartListProvider.removeFlower(temporalIndex);
                              context
                                  .read<CounterCartProvider>()
                                  .setDataCounter(counter: _cantidadProductos);

                              final snackBar = SnackBar(
                                  backgroundColor: Colors.red,
                                  duration: const Duration(seconds: 6),
                                  action: SnackBarAction(
                                      label: 'Regresar',
                                      onPressed: () {
                                        setState(() {
                                          print(
                                              '++++++++++++++++++TODA LA LISTA DE TEST PRODUCTS+++++++++++++++');
                                          for (var flower
                                              in watchProductTestProvider
                                                  .flores) {
                                            print(
                                                'id: ${flower.idProducto}, Descripcion: ${flower.descripcion} quantityToBuy: ${flower.precio}');
                                          }
                                          print(
                                              'Imprimir datos del producto eliminado previamente');
                                          print(
                                              'id: ${watchProductTestProvider.flores[temporalIndex].idProducto}, Descripcion: ${watchProductTestProvider.flores[temporalIndex].descripcion} quantityToBuy: $temporalQuantity');
                                          _previousContext
                                              .read<CartListProvider>()
                                              .addFlowerToCart(
                                                indexFlower:
                                                    watchProductTestProvider
                                                        .flores[temporalIndex]
                                                        .idProducto,
                                                quantityToBuy: temporalQuantity,
                                                imageUrl: null,
                                                type: ""
                                                // watchProductTestProvider
                                                //     .flores[temporalIndex]
                                                //     .tipo!
                                                ,
                                                description:
                                                    watchProductTestProvider
                                                        .flores[temporalIndex]
                                                        .descripcion,
                                                price: watchProductTestProvider
                                                    .flores[temporalIndex]
                                                    .precio,
                                              );
                                          calculationPriceAndQuantiy(
                                              watchCartListProvider);
                                          _previousContext
                                              .read<CounterCartProvider>()
                                              .setDataCounter(
                                                  counter: _cantidadProductos);
                                          print(
                                              '++++++++++++++++Esto es cantidad de porductos para recuperar totales en el carrito: $_cantidadProductos++++++++++++++++++');
                                        });
                                      }),
                                  content: const Text(
                                      'Removiste un producto de tu carrito. ¿Te arrepentiste?'));

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);

                              // print(
                              //     'Esto es el valor del contador del carrito: ${wacthConterCartProvider.counter}');
                              // print(
                              //     '--------Lista en carrito despues de remover dicha flore del carrito-------------');
                              // for (var flor in watchCartListProvider.flowers) {
                              //   print(
                              //       'indice de la flor: ${flor.indexFlower}, precio de la flor ${flor.price}');
                              // }
                              // print(
                              //     '----------------------------------------------------------------------------');
                              calculationPriceAndQuantiy(watchCartListProvider);
                              context
                                  .read<CounterCartProvider>()
                                  .setDataCounter(counter: _cantidadProductos);
                              print(
                                  '++++++++++++++++Esto es cantidad de pordutos totales en el carrito: $_cantidadProductos++++++++++++++++++');
                            });
                            // calculationRemovePriceAndQuantity(
                            //     watchCartListProvider);
                          },
                          icon: const Icon(Icons.delete_sharp),
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
                  'Aun no has agregado productos a tu carrito',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Capri",
                      color: Color.fromARGB(255, 150, 150, 150)),
                ),
                Icon(
                  Icons.shopping_cart,
                  color: Color.fromARGB(255, 196, 196, 196),
                ),
              ],
            ),
      bottomSheet: Container(
        color: const Color.fromARGB(255, 232, 168, 65),
        height: MediaQuery.of(context).size.height / 8,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Precio total:',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    const Icon(Icons.monetization_on, color: Colors.white),
                    Text(
                      '$_precioTotal',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Cantidad: ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: "Capri")),
                    Text(_cantidadProductos.toString(),
                        style: const TextStyle(
                            color: Colors.white, fontFamily: "Capri")),
                  ],
                ),
              ],
            ),
            ElevatedButton(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    iconColor: const MaterialStatePropertyAll(Colors.amber)),
                onPressed: () {},
                child: const Text('Comprar')),
          ],
        ),
      ),
    );
  }

  calculationPriceAndQuantiy(CartListProvider preciosFlores) {
    setState(() {
      _precioTotal = 0;
      _cantidadProductos = 0;
      for (var flor in preciosFlores.flowers) {
        _precioTotal += flor.price * flor.quantityToBuy;
        _cantidadProductos += flor.quantityToBuy;
      }
      print(
          '-------------Metodo calcular precio y cantidad totales----------------------');
      print('precio total adicionado en metodo adicionar$_precioTotal');
      print('Cantidad total$_cantidadProductos');
      print(
          '--------------------------------------------------------------------------');
    });
  }

  // calculationRemovePrice(int priceRemove) {
  //   _precioTotal -= priceRemove;
  //   _cantidadProductos--;
  //   print('precio total adicionado en metodo remover$_precioTotal');
  // }

  // calculationRemovePriceAndQuantity(CartListProvider preciosFlores) {
  //   setState(() {
  //     _precioTotal = 0;
  //     _cantidadProductos = 0;
  //     for (var flor in preciosFlores.flowers) {
  //       _precioTotal -= flor.price * flor.quantityToBuy;
  //       _cantidadProductos -= flor.quantityToBuy;

  //     }
  //     print('precio total adicionado en metodo adicionar$_precioTotal');
  //   });
  // }
}
