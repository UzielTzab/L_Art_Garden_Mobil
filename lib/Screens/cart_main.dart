import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/AnimationRoutes/routeAnimatedBottomToTop.dart';
import 'package:l_art_garden_mobil/Screens/buy_screen.dart';
import 'package:l_art_garden_mobil/model_provider/cartListProvider.dart';
import 'package:l_art_garden_mobil/model_provider/counter_cart.dart';
import 'product_screee.dart';
import 'package:l_art_garden_mobil/model_provider/products_provider.dart';
import 'package:provider/provider.dart';

class CartMain extends StatefulWidget {
  const CartMain({super.key});

  @override
  State<CartMain> createState() => _CartMainState();
}

class _CartMainState extends State<CartMain> {
  double _bottomSheetOpacity = 1.0;
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
    ProductProvider watchProductTestProvider = context.watch<ProductProvider>();
    for (var flor in watchCartListProvider.products) {
      print('id: ${flor.idProduct}     precio: ${flor.price}');
    }

    calculationPriceAndQuantiy(watchCartListProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Icon(
              Icons.shopping_cart,
              color: Color.fromARGB(255, 98, 84, 52),
            ),
            const Text(
              'Carrito',
              style: TextStyle(color: Color.fromARGB(255, 98, 84, 52)),
            ),
          ],
        ),
      ),
      body: watchCartListProvider.products.isNotEmpty
          ? ListView.builder(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 8),
              itemCount: watchCartListProvider.products.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 0,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                            watchCartListProvider.products[index].description),
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
                                  '${watchCartListProvider.products[index].price}',
                                  style: TextStyle(color: orangeColor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Row(
                                    children: [
                                      if (watchCartListProvider
                                              .products[index].quantityToBuy >
                                          1)
                                        IconButton(
                                          onPressed: () {
                                            print('remove only one product?');
                                            setState(() {
                                              calculationPriceAndQuantiy(
                                                  watchCartListProvider);
                                              int temporalIndex =
                                                  watchCartListProvider
                                                      .products[index]
                                                      .idProduct;

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
                                          isSelected: false,
                                          onPressed: null,
                                          icon: const Icon(Icons.remove),
                                        ),
                                      Text(
                                        watchCartListProvider
                                            .products[index].quantityToBuy
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                255, 31, 108, 10)),
                                      ),
                                      IconButton(
                                        onPressed: watchCartListProvider
                                                    .products[index]
                                                    .quantityToBuy <
                                                watchProductTestProvider
                                                    .products
                                                    .firstWhere((product) =>
                                                        product.idProducto ==
                                                        watchCartListProvider
                                                            .products[index]
                                                            .idProduct)
                                                    .stock
                                            ? () {
                                                setState(() {
                                                  calculationPriceAndQuantiy(
                                                      watchCartListProvider);
                                                  int temporalIdProduct =
                                                      watchCartListProvider
                                                          .products[index]
                                                          .idProduct;

                                                  // Buscar el producto correcto en watchProductTestProvider.products
                                                  var productToAdd =
                                                      watchProductTestProvider
                                                          .products
                                                          .firstWhere(
                                                    (product) =>
                                                        product.idProducto ==
                                                        temporalIdProduct,
                                                  );

                                                  if (productToAdd.stock >
                                                      watchCartListProvider
                                                          .products[index]
                                                          .quantityToBuy) {
                                                    _previousContext
                                                        .read<
                                                            CartListProvider>()
                                                        .addProductToCart(
                                                          indexProduct:
                                                              productToAdd
                                                                  .idProducto,
                                                          idCategory:
                                                              productToAdd
                                                                  .idCategoria,
                                                          idInvetory:
                                                              productToAdd
                                                                  .idInventario,
                                                          quantityToBuy: 1,
                                                          image1: productToAdd
                                                              .imagen1,
                                                          image2: productToAdd
                                                              .imagen2,
                                                          image3: productToAdd
                                                              .imagen3,
                                                          image4: productToAdd
                                                              .imagen4,
                                                          image5: productToAdd
                                                              .imagen5,
                                                          stock: productToAdd
                                                              .stock,
                                                          description:
                                                              productToAdd
                                                                  .descripcion,
                                                          price: productToAdd
                                                              .precio,
                                                        );
                                                    calculationPriceAndQuantiy(
                                                        watchCartListProvider);

                                                    _previousContext
                                                        .read<
                                                            CounterCartProvider>()
                                                        .setDataCounter(
                                                            counter:
                                                                _cantidadProductos);
                                                  }
                                                });
                                              }
                                            : null, // Si la cantidad elegida es mayor o igual al stock del producto, onPressed será null y el botón estará deshabilitado
                                        icon: const Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        leading: Image.network(
                            'https://floresfinas.oss-us-east-1.aliyuncs.com/mj-v1/arreglo-floral-m4067-1.webp'),
                        onTap: () {
                          int temporalIdProduct =
                              watchCartListProvider.products[index].idProduct;
                          int indexProduct = watchProductTestProvider.products
                              .indexWhere((product) =>
                                  product.idProducto == temporalIdProduct);

                          if (indexProduct != -1) {
                            Navigator.of(context).push(
                                PageRoutesFree.createPageRoute(ProductScreen(
                                    watchCartListProvider
                                        .products[index].idProduct)));
                          } else {
                            print(
                                'Producto no encontrado en la lista de productos');
                          }
                        },
                        trailing: IconButton(
                          color: orangeColor,
                          onPressed: () {
                            setState(() {
                              int temporalIndex = watchCartListProvider
                                  .products[index].idProduct;
                              print(
                                  'Cantidad de productos: $_cantidadProductos');

                              int temporalQuantity = 0;
                              temporalQuantity = watchCartListProvider
                                  .products[index].quantityToBuy;

                              watchCartListProvider
                                  .removeAllFlower(temporalIndex);
                              context
                                  .read<CounterCartProvider>()
                                  .setDataCounter(counter: _cantidadProductos);

                              final snackBar = SnackBar(
                                  backgroundColor: Colors.red,
                                  duration: const Duration(seconds: 6),
                                  action: SnackBarAction(
                                      textColor: Colors.white,
                                      label: 'Regresar',
                                      onPressed: () {
                                        setState(() {
                                          print(
                                              '++++++++++++++++++TODA LA LISTA DE TEST PRODUCTS+++++++++++++++');
                                          for (var flower
                                              in watchProductTestProvider
                                                  .products) {
                                            print(
                                                'id: ${flower.idProducto}, Descripcion: ${flower.descripcion} quantityToBuy: ${flower.precio}');
                                          }
                                          print(
                                              'Imprimir datos del producto eliminado previamente');
                                          var productToReAdd =
                                              watchProductTestProvider.products
                                                  .firstWhere((product) =>
                                                      product.idProducto ==
                                                      temporalIndex);
                                          print(
                                              'id: ${productToReAdd.idProducto}, Descripcion: ${productToReAdd.descripcion} quantityToBuy: $temporalQuantity');
                                          _previousContext
                                              .read<CartListProvider>()
                                              .addProductToCart(
                                                indexProduct:
                                                    productToReAdd.idProducto,
                                                idCategory:
                                                    productToReAdd.idCategoria,
                                                idInvetory:
                                                    productToReAdd.idInventario,
                                                quantityToBuy: temporalQuantity,
                                                image1: productToReAdd.imagen1,
                                                image2: productToReAdd.imagen2,
                                                image3: productToReAdd.imagen3,
                                                image4: productToReAdd.imagen4,
                                                image5: productToReAdd.imagen5,
                                                stock: productToReAdd.stock,
                                                description:
                                                    productToReAdd.descripcion,
                                                price: productToReAdd.precio,
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
      bottomSheet: Opacity(
        opacity: _bottomSheetOpacity,
        child: Container(
          color: Color.fromARGB(255, 230, 174, 95),
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
                        '$_precioTotal MXN',
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
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(0, 60, 49, 88)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                                color: const Color.fromARGB(
                                    255, 255, 255, 255))))),
                onPressed: _cantidadProductos > 0
                    ? () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                BuyScreen(
                                    totalAmount: _precioTotal,
                                    totalQuantity: _cantidadProductos),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              var begin = Offset(0.0, 1.0);
                              var end = Offset.zero;
                              var curve = Curves.ease;

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));

                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                          ),
                        );
                      }
                    : () {
                        final snackBar = SnackBar(
                          content: Text('Tu carrito esta vacio'),
                          duration: Duration(seconds: 1),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                child: const Text(
                  'Continuar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  calculationPriceAndQuantiy(CartListProvider preciosFlores) {
    setState(() {
      _precioTotal = 0;
      _cantidadProductos = 0;
      for (var flor in preciosFlores.products) {
        _precioTotal += flor.price * flor.quantityToBuy;
        _cantidadProductos += flor.quantityToBuy;
      }
      _precioTotal = double.parse(
          _precioTotal.toStringAsFixed(2)); // Limit to 2 decimal places
      print(
          '-------------Metodo calcular precio y cantidad totales----------------------');
      print('precio total adicionado en metodo adicionar$_precioTotal MXN');
      print('Cantidad total$_cantidadProductos');
      print(
          '--------------------------------------------------------------------------');
    });
  }
}
