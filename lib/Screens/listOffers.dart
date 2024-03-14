import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/AnimationRoutes/routeAnimatedBottomToTop.dart';
import 'package:l_art_garden_mobil/model_provider/products_test_provider.dart';
import 'package:provider/provider.dart';
import 'CarouselFlowerShops.dart';
import 'productScreee.dart';
// import 'ProductPresentation.dart';

class CustomListOffers extends StatefulWidget {
  const CustomListOffers({super.key});
  @override
  State<CustomListOffers> createState() => _CustomScrollViewState();
}

class _CustomScrollViewState extends State<CustomListOffers> {
  static const List<String> list = <String>["Rojo", "Blanco", "Morado", "Azul"];
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    ProductsTestProvider watchProductTestProvider =
        context.watch<ProductsTestProvider>();

    print("Longitud de la lista: ${watchProductTestProvider.flores.length}");
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: Container(),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          expandedHeight: 100,
          floating: true,
          flexibleSpace: const Padding(
            padding: EdgeInsets.all(5.0),
            child: CarouselSliderWithDots(),
          ),
        ),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 6.0,
              mainAxisSpacing: 6.0,
              childAspectRatio: 0.6),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              print('Aqui esta el indice de gridSliverList $index');
              return Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10),
                  // border: Border.all(
                  //   color: Color.fromARGB(95, 26, 26, 26),
                  //   style: BorderStyle.solid,
                  //   width: 2,
                  // ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 180,
                      decoration: const BoxDecoration(color: Colors.amber),
                      child: InkWell(
                        onTap: () {
                          // Navegar a la nueva pantalla cuando se toca la imagen
                          Navigator.of(context).push(
                              PageRoutesFree.createPageRoute(
                                  ProductScreen(index)));
                        },
                        child: const Icon(Icons.image),
                      ),
                    ),
                    Container(
                      height: 100,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              watchProductTestProvider
                                  .flores[index].descripcion,
                              style: const TextStyle(fontSize: 12),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.attach_money_sharp,
                                  size: 15,
                                  color: Color.fromARGB(255, 209, 137, 49),
                                ),
                                Text(
                                  '${watchProductTestProvider.flores[index].precio.toString()} MXN',
                                  style: const TextStyle(
                                      fontFamily: "Arial",
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 209, 137, 49)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            childCount: watchProductTestProvider.flores.length,
          ),
        ),
      ],
    );
  }
}
