import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/model_provider/cart_provider.dart';
import 'package:l_art_garden_mobil/model_provider/counter_cart.dart';

import 'package:l_art_garden_mobil/model_provider/products_test_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

class CartMain extends StatefulWidget {
  const CartMain({super.key});

  @override
  State<CartMain> createState() => _CartMainState();
}

class _CartMainState extends State<CartMain> {
  double _precioTotal = 0;
  int _cantidadProductos = 0;

  @override
  Widget build(BuildContext context) {
    Color _orangeColor = Color.fromARGB(255, 209, 137, 49);
    CounterCartProvider wacthConterCartProvider =
        context.watch<CounterCartProvider>();
    CartProvider watchCartProvider = context.watch<CartProvider>();
    ProductsTestProvider watchProductTestProvider =
        context.watch<ProductsTestProvider>();
    for (var flor in watchCartProvider.flores) {
      print('id: ${flor.indexFlower}     precio: ${flor.precio}');
    }
    calculationAddPrice(watchCartProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Carrito'),
      ),
      body: ListView.builder(
        itemCount: watchCartProvider.flores.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 0,
            child: Column(
              children: [
                ListTile(
                  title: Text('${watchCartProvider.flores[index].descripcion}'),
                  subtitle: Row(
                    children: [
                      Icon(
                        Icons.monetization_on,
                        color: _orangeColor,
                      ),
                      Text(
                        '${watchCartProvider.flores[index].precio}',
                        style: TextStyle(color: _orangeColor),
                      ),
                    ],
                  ),
                  leading:
                      Image.network(watchCartProvider.flores[index].imageUrl),
                  onTap: () {
                    // Acción cuando se toca la carta
                  },
                  trailing: IconButton(
                    color: _orangeColor,
                    onPressed: () {
                      int temporalIndex =
                          watchCartProvider.flores[index].indexFlower;
                      print('Esto es temporal index: $temporalIndex');
                      calculationRemovePrice(watchProductTestProvider
                          .flores[temporalIndex].precio);
                      print(
                          '--------Lista en carrito antes de remover dicha flore del carrito-------------');
                      for (var flor in watchCartProvider.flores) {
                        print(
                            'indice de la flor: ${flor.indexFlower}, precio de la flor ${flor.precio}');
                      }
                      print(
                          '----------------------------------------------------------------------------');
                      context
                          .read<CounterCartProvider>()
                          .setDataCounter(counter: _cantidadProductos);
                      watchCartProvider.removeFlower(temporalIndex);

                      print(
                          'Esto es el valor del contador del carrito: ${wacthConterCartProvider.counter}');
                      print(
                          '--------Lista en carrito despues de remover dicha flore del carrito-------------');
                      for (var flor in watchCartProvider.flores) {
                        print(
                            'indice de la flor: ${flor.indexFlower}, precio de la flor ${flor.precio}');
                      }
                      print(
                          '----------------------------------------------------------------------------');
                    },
                    icon: const Icon(Icons.remove),
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
                    iconColor: MaterialStatePropertyAll(Colors.amber)),
                onPressed: () {},
                child: Text('Comprar')),
          ],
        ),
      ),
    );
  }

  calculationAddPrice(CartProvider preciosFlores) {
    setState(() {
      _precioTotal = 0;
      _cantidadProductos = 0;
      for (var flor in preciosFlores.flores) {
        _precioTotal += flor.precio;
        _cantidadProductos++;
      }
      print('precio total adicionado en metodo adicionar$_precioTotal');
    });
  }

  calculationRemovePrice(int priceRemove) {
    _precioTotal -= priceRemove;
    _cantidadProductos--;
    print('precio total adicionado en metodo remover$_precioTotal');
  }
}
