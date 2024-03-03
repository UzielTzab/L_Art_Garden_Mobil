import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/Utils/porductsCrud.dart';
import 'package:l_art_garden_mobil/model_provider/products_test_provider.dart';

class CalssicButton extends StatelessWidget {
  final int typeOperation;
  final BuildContext widgetContext;
  final ProductsTestProvider wacthProductTestProvider;
  final int widgetIndex;
  final int counterCartProvider;

  const CalssicButton(
      {required this.counterCartProvider,
      required this.wacthProductTestProvider,
      required this.widgetIndex,
      required this.widgetContext,
      required this.typeOperation,
      super.key});

  @override
  Widget build(BuildContext context) {
    CrudProducts crudProducts = CrudProducts();
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        backgroundColor:
            MaterialStateProperty.all(Color.fromARGB(255, 235, 161, 65)),
      ),
      onPressed: () {
        switch (typeOperation) {
          case 1:
            crudProducts.Addproduct(widgetContext, wacthProductTestProvider,
                widgetIndex, counterCartProvider);
            break;
          //   case 2:
          //     crudProducts.RemoveProduct(widgetContext, wacthProductTestProvider,
          //         widgetIndex, counterCartProvider);
          // }
        }
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
    );
  }
}
