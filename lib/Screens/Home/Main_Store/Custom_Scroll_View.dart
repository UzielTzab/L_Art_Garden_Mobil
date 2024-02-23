import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/model_provider/products.dart';
import 'package:provider/provider.dart';
import 'CarouselFlowerShops.dart';
import 'ProductPresentation.dart';
// import 'ProductPresentation.dart';

class CustomScrollViewClass extends StatefulWidget {
  const CustomScrollViewClass({Key? key}) : super(key: key);
  @override
  State<CustomScrollViewClass> createState() => _CustomScrollViewState();
}

class _CustomScrollViewState extends State<CustomScrollViewClass> {
  final List<String> imageUrls = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwHDYrj9GF3FRJXPyk0hkHJeg1kCPWhk5_6g&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXL4BrCGSKFdlL-vgTHU6DaaChK4xrkZRNNA&usqp=CAU',
    'https://www.folimg.com/kernel/imageload/?table=fol3_catalog_images&key1=E5440_large_feature_better&key2=E5440_feature_better&key3=E5440_large_better&key4=E5440_large_thumb_better',
    'https://www.folimg.com/kernel/imageload/?table=fol3_catalog_images&key1=CJB_large_feature_better&key2=CJB_feature_better&key3=CJB_large_better&key4=CJB_large_thumb_better',
    'https://www.folimg.com/kernel/imageload/?table=fol3_catalog_images&key1=FLG_large_feature&key2=FLG_feature&key3=FLG_large&key4=FLG_large_thumb',
    'https://www.folimg.com/kernel/imageload/?table=fol3_catalog_images&key1=D9-4911_large_feature_better&key2=D9-4911_feature_better&key3=D9-4911_large_better&key4=D9-4911_large_thumb_better',
    'https://www.folimg.com/kernel/imageload/?table=fol3_catalog_images&key1=V1RS-CH_large_feature&key2=V1RS-CH_feature&key3=V1RS-CH_large&key4=V1RS-CH_large_thumb',
    'https://www.folimg.com/kernel/imageload/?table=fol3_catalog_images&key1=V5510_large_feature_better&key2=V5510_feature_better&key3=V5510_large_better&key4=V5510_large_thumb_better',
    'https://www.folimg.com/kernel/imageload/?table=fol3_catalog_images&key1=E3-5238_large_feature&key2=E3-5238_feature&key3=E3-5238_large&key4=E3-5238_large_thumb',
    'https://www.folimg.com/kernel/imageload/?table=fol3_catalog_images&key1=F5512_large_feature_better&key2=F5512_feature_better&key3=F5512_large_better&key4=F5512_large_thumb_better',
    'https://www.folimg.com/kernel/imageload/?table=fol3_catalog_images&key1=PGP_large_feature_better&key2=PGP_feature_better&key3=PGP_large_better&key4=PGP_large_thumb_better',
    'https://www.folimg.com/kernel/imageload/?table=fol3_catalog_images&key1=D7-4906_large_feature_better&key2=D7-4906_feature_better&key3=D7-4906_large_better&key4=D7-4906_large_thumb_better',
    'https://www.folimg.com/kernel/imageload/?table=fol3_catalog_images&key1=FLW_large_feature&key2=FLW_feature&key3=FLW_large&key4=FLW_large_thumb'

    // Agrega más URLs según sea necesario
  ];
  static const List<String> list = <String>["Rojo", "Blanco", "Morado", "Azul"];
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    ProductsProvider productsProvider = context.watch<ProductsProvider>();

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
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 0.0,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: 600,
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color.fromARGB(0, 189, 119, 58),
                        style: BorderStyle.solid,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            // Navegar a la nueva pantalla cuando se toca la imagen
                            Navigator.of(context)
                                .push(_createPageRoute(imageUrls, index));
                          },
                          child: Image.network(
                            imageUrls[index],
                            width: 120.0,
                            height: 120.0,
                          ),
                        ),
                        const Text('Nombre del arreglo'),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.monetization_on_outlined,
                              size: 10,
                              color: Color.fromARGB(255, 75, 195, 71),
                            ),
                            Text(
                              '450',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Color.fromARGB(255, 75, 195, 71)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            childCount: 13,
          ),
        ),
      ],
    );
  }

  Route _createPageRoute(List<String> imageUrls, int index) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          YourNewScreen(imageUrls, index),
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
