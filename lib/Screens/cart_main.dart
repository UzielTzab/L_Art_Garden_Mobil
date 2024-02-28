import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/model_provider/cart_provider.dart';
import 'package:l_art_garden_mobil/model_provider/flower_product_provider.dart';
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
    CartProvider watchCartProvider = context.watch<CartProvider>();
    CalcularPrecioFinal(watchCartProvider);
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
                    onPressed: () {},
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
        color: Color.fromARGB(255, 232, 168, 65),
        height: MediaQuery.of(context).size.height / 8,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Precio total: $_precioTotal',
              style: const TextStyle(color: Colors.white),
            ),
            Text('Cantidad de productos: $_cantidadProductos',
                style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  CalcularPrecioFinal(CartProvider preciosFlores) {
    setState(() {
      for (var flor in preciosFlores.flores) {
        _precioTotal += flor.precio;
        _cantidadProductos++;
      }
      print(_precioTotal);
    });
  }
}
