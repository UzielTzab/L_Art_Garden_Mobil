import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/model_provider/products_test_provider.dart';
import 'package:provider/provider.dart';
import 'CarouselFlowerShops.dart';
import 'productScreee.dart';
// import 'ProductPresentation.dart';

class CustomListRamos extends StatefulWidget {
  const CustomListRamos({Key? key}) : super(key: key);
  @override
  State<CustomListRamos> createState() => _CustomScrollViewState();
}

class _CustomScrollViewState extends State<CustomListRamos> {
  static const List<String> list = <String>["Rojo", "Blanco", "Morado", "Azul"];
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    // FlowerProvider watchFlowerProvider = context.watch<FlowerProvider>();
    ProductsTestProvider watchProductTestProvider =
        context.watch<ProductsTestProvider>();
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
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 8.0,
            // childAspectRatio: 1,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              print('Aqui esta el indice de gridSliverList $index');
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    width: 150,
                    height: 1500,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(47, 210, 210, 210),
                      borderRadius: BorderRadius.circular(10),
                      // border: Border.all(
                      //   color: Color.fromARGB(95, 26, 26, 26),
                      //   style: BorderStyle.solid,
                      //   width: 2,
                      // ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            // Navegar a la nueva pantalla cuando se toca la imagen
                            Navigator.of(context).push(_createPageRoute(
                                watchProductTestProvider.GetUrl(), index));
                          },
                          child: const Icon(Icons.image),
                        ),
                        Container(
                          color: Color.fromARGB(255, 255, 255, 255),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                watchProductTestProvider
                                    .flores[index].descripcion,
                                style: TextStyle(fontSize: 12),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.monetization_on,
                                    size: 15,
                                    color: Color.fromARGB(255, 209, 137, 49),
                                  ),
                                  Text(
                                    watchProductTestProvider
                                        .flores[index].precio
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color:
                                            Color.fromARGB(255, 209, 137, 49)),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            childCount: 7,
          ),
        ),
      ],
    );
  }

  Route _createPageRoute(List<String> imageUrls, int index) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          ProductScreen(index),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
