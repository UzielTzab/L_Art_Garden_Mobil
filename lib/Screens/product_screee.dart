import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/Models/product.dart';
import 'package:l_art_garden_mobil/Screens/cart_main.dart';
import 'package:l_art_garden_mobil/model_provider/cartListProvider.dart';
import 'package:l_art_garden_mobil/model_provider/cart_provider.dart';
import 'package:l_art_garden_mobil/model_provider/counter_cart.dart';
import 'package:l_art_garden_mobil/model_provider/favorites_provider.dart';
import 'package:l_art_garden_mobil/model_provider/products_provider.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';

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
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final List<String> imgListProduct = [
      '[url=https://postimg.cc/4mR7qr52][img]https://i.postimg.cc/4mR7qr52/02-Clasico-Amor-con-24-rosas-rojas.jpg[/img][/url]',
      '[url=https://postimg.cc/HJnVbHYn][img]https://i.postimg.cc/HJnVbHYn/100-Rosas-Rosa-Intenso-en-Jarron-f1.jpg[/img][/url]',
      '[url=https://postimg.cc/xX0kTMBK][img]https://i.postimg.cc/xX0kTMBK/10-tulipanes-rojos-africa-P.jpg[/img][/url]',
      '[url=https://postimg.cc/fSny49xS][img]https://i.postimg.cc/fSny49xS/12-Rosas-Blancas-PR.jpg[/img][/url]',
      '[url=https://postimg.cc/CdsnycQF][img]https://i.postimg.cc/CdsnycQF/Ternura-con-6-Rosas-y-Lilys-principal-1.jpg[/img][/url]',
    ];
    final List<String> imgList = [
      'https://floresfinas.oss-us-east-1.aliyuncs.com/mj-v1/arreglo-floral-m4067-1.webp',
      'https://floresfinas.oss-us-east-1.aliyuncs.com/mj-v1/arreglo-floral-m4067-1.webp',
      'https://floresfinas.oss-us-east-1.aliyuncs.com/mj-v1/arreglo-floral-m4067-1.webp',
      'https://floresfinas.oss-us-east-1.aliyuncs.com/mj-v1/arreglo-floral-m4067-1.webp',
      'https://floresfinas.oss-us-east-1.aliyuncs.com/mj-v1/arreglo-floral-m4067-1.webp',
    ];
    CounterCartProvider watchCounterProvider =
        context.watch<CounterCartProvider>();

    ProductProvider watchProductProvider = context.watch<ProductProvider>();
    watchProductProvider.products.forEach((product) {
      print(
          'idProducto: ${product.idProducto}, Producto: ${product.nombre}, Precio: ${product.precio}');
    });
    FavoritesProvider watchFavoritesProvider =
        context.watch<FavoritesProvider>();
    print(
        "Hola, esto es el valor del indice del producto que estas pasando para verlo: ${widget.index}");

    CartListProvider watchListCartProvider = context.watch<CartListProvider>();
    if (watchFavoritesProvider
        .findProduct(watchProductProvider.products[widget.index].idProducto)) {
      isPressedFavorite = true;
    }
    // Comprueba si el producto ya está en el carrito
    if (watchListCartProvider
        .findProduct(watchProductProvider.products[widget.index].idProducto)) {
      isPressedAddCart = true;
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
                CarouselSlider(
                  options: CarouselOptions(
                    height: 300,
                    autoPlay: true,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  items: imgList
                      .map((item) => Container(
                            child: Center(
                              child: Image.network(item,
                                  fit: BoxFit.cover, width: 1500),
                            ),
                          ))
                      .toList(),
                ),
                DotsIndicator(
                  dotsCount: imgList.length,
                  position: _currentIndex.toInt(),
                ),
                IconButton.outlined(
                  icon: isPressedFavorite
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite_outline_rounded),
                  onPressed: () {
                    setState(() {
                      isPressedFavorite = !isPressedFavorite;
                    });

                    if (isPressedFavorite) {
                      print('Agrgaste el producto');
                      Product product = Product(
                          idProducto: watchProductProvider
                              .products[widget.index].idProducto,
                          idCategoria: watchProductProvider
                              .products[widget.index].idCategoria,
                          idInventario: watchProductProvider
                              .products[widget.index].idInventario,
                          nombre: watchProductProvider
                              .products[widget.index].nombre,
                          descripcion: watchProductProvider
                              .products[widget.index].descripcion,
                          precio: watchProductProvider
                              .products[widget.index].precio,
                          imagen1: watchProductProvider
                              .products[widget.index].imagen1,
                          imagen2: watchProductProvider
                              .products[widget.index].imagen2,
                          imagen3: watchProductProvider
                              .products[widget.index].imagen3,
                          imagen4: watchProductProvider
                              .products[widget.index].imagen4,
                          imagen5: watchProductProvider
                              .products[widget.index].imagen5,
                          stock:
                              watchProductProvider.products[widget.index].stock,
                          nombreFloreria: watchProductProvider
                              .products[widget.index].nombreFloreria,
                          nombreCategoria: watchProductProvider
                              .products[widget.index].nombreCategoria);
                      if (!context
                          .read<FavoritesProvider>()
                          .findProduct(product.idProducto)) {
                        context.read<FavoritesProvider>().addProduct(product);
                      }

                      // Imprimir el producto añadido a favoritos
                      print(
                          'Producto añadido a favoritos:${product.idProducto}, ${product.nombre}, ${product.descripcion}, ${product.precio}');

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
                      context.read<FavoritesProvider>().removeProduct(
                          watchProductProvider
                              .products[widget.index].idProducto);
                      // Imprimir el producto removido de favoritos
                      print(
                          'Producto removido de favoritos: ${watchProductProvider.products[widget.index].idProducto}, ${watchProductProvider.products[widget.index].nombre}, ${watchProductProvider.products[widget.index].descripcion}, ${watchProductProvider.products[widget.index].precio}');

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
                    Text(watchProductProvider.products[widget.index].nombre,
                        style: const TextStyle(fontSize: 38)),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: Text(
                          watchProductProvider
                              .products[widget.index].descripcion,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
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
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                                Text('Stock disponible de este producto: '),
                                Text(
                                  watchProductProvider
                                      .products[widget.index].stock
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 255, 171, 62)),
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
                                Text('Precio: '),
                                Text(
                                  '${watchProductProvider.products[widget.index].precio.toString()}MXN',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 255, 171, 62),
                                      fontFamily: "Arial"),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.store,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                                Text('FLoreria: '),
                                Expanded(
                                  child: Text(
                                    watchProductProvider
                                        .products[widget.index].nombreFloreria
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        color:
                                            Color.fromARGB(255, 255, 171, 62)),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.category_outlined,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                                Text('Categoria: '),
                                Text(
                                  watchProductProvider
                                      .products[widget.index].nombreCategoria
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 255, 171, 62)),
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
                      //     wacthProductTestProvider: watchProductProvider,
                      //     widgetIndex: widget.index,
                      //     widgetContext: context,
                      //     typeOperation: 1),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 235, 161, 65),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            isPressedAddCart = !isPressedAddCart;
                          });

                          if (isPressedAddCart) {
                            context.read<CounterCartProvider>().setDataCounter(
                                  counter: watchCounterProvider.counter + 1,
                                );

                            context.read<CartListProvider>().addProductToCart(
                                  indexProduct: watchProductProvider
                                      .products[widget.index].idProducto,
                                  idCategory: watchProductProvider
                                      .products[widget.index].idCategoria,
                                  idInvetory: watchProductProvider
                                      .products[widget.index].idInventario,
                                  image1: watchProductProvider
                                      .products[widget.index].imagen1,
                                  image2: watchProductProvider
                                      .products[widget.index].imagen2,
                                  image3: watchProductProvider
                                      .products[widget.index].imagen3,
                                  image4: watchProductProvider
                                      .products[widget.index].imagen4,
                                  image5: watchProductProvider
                                      .products[widget.index].imagen5,
                                  description: watchProductProvider
                                      .products[widget.index].descripcion,
                                  price: watchProductProvider
                                      .products[widget.index].precio,
                                  stock: watchProductProvider
                                      .products[widget.index].stock,
                                  quantityToBuy: 1,
                                );

                            final snackBar = SnackBar(
                              duration: const Duration(seconds: 1),
                              backgroundColor:
                                  const Color.fromARGB(255, 224, 169, 6),
                              content: const Text(
                                  '¡Agregaste este producto al carrito!'),
                              action: SnackBarAction(
                                label: 'Omitir',
                                textColor: Colors.white,
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            int quantity = context
                                .read<CartListProvider>()
                                .getQuantity(watchProductProvider
                                    .products[widget.index].idProducto);
                            context.read<CartListProvider>().removeAllFlower(
                                watchProductProvider
                                    .products[widget.index].idProducto);
                            context.read<CounterCartProvider>().setDataCounter(
                                  counter:
                                      watchCounterProvider.counter - quantity,
                                );

                            final snackBar = SnackBar(
                              duration: const Duration(seconds: 1),
                              backgroundColor:
                                  const Color.fromARGB(255, 224, 35, 6),
                              content: const Text(
                                  'Quitaste este producto del carrito'),
                              action: SnackBarAction(
                                textColor: Colors.white,
                                label: 'Omitir',
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isPressedAddCart
                                  ? 'Agregado'
                                  : 'Agregar al carrito',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontFamily: "Capri",
                              ),
                            ),
                            Icon(
                              isPressedAddCart
                                  ? Icons.check
                                  : Icons.add_shopping_cart,
                              color: Color.fromARGB(255, 255, 255, 255),
                            )
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
