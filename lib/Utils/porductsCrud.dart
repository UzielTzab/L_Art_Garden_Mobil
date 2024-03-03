import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/Widgets/classicSnackBar.dart';
import 'package:l_art_garden_mobil/model_provider/cartListProvider.dart';
import 'package:l_art_garden_mobil/model_provider/cart_provider.dart';
import 'package:l_art_garden_mobil/model_provider/counter_cart.dart';
import 'package:l_art_garden_mobil/model_provider/products_test_provider.dart';
import 'package:provider/provider.dart';

class CrudProducts {
  void Addproduct(
      BuildContext context,
      ProductsTestProvider wacthProductTestProvider,
      int widgetIndex,
      int counterCartProvider) {
    context
        .read<CounterCartProvider>()
        .setDataCounter(counter: counterCartProvider + 1);

    context.read<CartListProvider>().addFlowerToCart(
          indexFlower: wacthProductTestProvider.flores[widgetIndex].indexFlower,
          imageUrl: wacthProductTestProvider.flores[widgetIndex].imageUrl,
          description: wacthProductTestProvider.flores[widgetIndex].descripcion,
          price: wacthProductTestProvider.flores[widgetIndex].precio,
          type: wacthProductTestProvider.flores[widgetIndex].tipo,
          quantityToBuy: 0,
        );
    ClassicSnackBar(
        title: '¡Agregaste correctamente este producto!',
        buttonTitle: 'Omitir');
  }

  void RemoveProduct() {}
  void updateProduct() {}
}
