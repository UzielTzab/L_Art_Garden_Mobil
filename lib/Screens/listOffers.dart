import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/AnimationRoutes/routeAnimatedBottomToTop.dart';
import 'package:l_art_garden_mobil/model_provider/products_test_provider.dart';
import 'package:provider/provider.dart';
import 'CarouselFlowerShops.dart';
import 'productScreee.dart';
// import 'ProductPresentation.dart';

class CustomListOffers extends StatefulWidget {
  const CustomListOffers({Key? key}) : super(key: key);
  @override
  State<CustomListOffers> createState() => _CustomScrollViewState();
}

class _CustomScrollViewState extends State<CustomListOffers> {
  // final List<String> imageUrls = [
  //   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwHDYrj9GF3FRJXPyk0hkHJeg1kCPWhk5_6g&usqp=CAU',
  //   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXL4BrCGSKFdlL-vgTHU6DaaChK4xrkZRNNA&usqp=CAU',
  //   'https://www.folimg.com/kernel/imageload/?table=fol3_catalog_images&key1=E5440_large_feature_better&key2=E5440_feature_better&key3=E5440_large_better&key4=E5440_large_thumb_better',
  //   'https://www.folimg.com/kernel/imageload/?table=fol3_catalog_images&key1=CJB_large_feature_better&key2=CJB_feature_better&key3=CJB_large_better&key4=CJB_large_thumb_better',
  //   'https://www.folimg.com/kernel/imageload/?table=fol3_catalog_images&key1=FLG_large_feature&key2=FLG_feature&key3=FLG_large&key4=FLG_large_thumb',
  //   'https://www.folimg.com/kernel/imageload/?table=fol3_catalog_images&key1=D9-4911_large_feature_better&key2=D9-4911_feature_better&key3=D9-4911_large_better&key4=D9-4911_large_thumb_better',
  //   'https://www.folimg.com/kernel/imageload/?table=fol3_catalog_images&key1=V1RS-CH_large_feature&key2=V1RS-CH_feature&key3=V1RS-CH_large&key4=V1RS-CH_large_thumb',
  //   'https://www.folimg.com/kernel/imageload/?table=fol3_catalog_images&key1=V5510_large_feature_better&key2=V5510_feature_better&key3=V5510_large_better&key4=V5510_large_thumb_better',
  //   'https://www.folimg.com/kernel/imageload/?table=fol3_catalog_images&key1=E3-5238_large_feature&key2=E3-5238_feature&key3=E3-5238_large&key4=E3-5238_large_thumb',
  //   'https://www.folimg.com/kernel/imageload/?table=fol3_catalog_images&key1=F5512_large_feature_better&key2=F5512_feature_better&key3=F5512_large_better&key4=F5512_large_thumb_better',
  //   'https://www.folimg.com/kernel/imageload/?table=fol3_catalog_images&key1=PGP_large_feature_better&key2=PGP_feature_better&key3=PGP_large_better&key4=PGP_large_thumb_better',
  //   'https://www.folimg.com/kernel/imageload/?table=fol3_catalog_images&key1=D7-4906_large_feature_better&key2=D7-4906_feature_better&key3=D7-4906_large_better&key4=D7-4906_large_thumb_better',
  //   'https://www.folimg.com/kernel/imageload/?table=fol3_catalog_images&key1=FLW_large_feature&key2=FLW_feature&key3=FLW_large&key4=FLW_large_thumb'

  //   // Agrega más URLs según sea necesario
  // ];
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
                            Navigator.of(context)
                                .push(PageRoutes.createPageRoute(index));
                          },
                          child: Image.network(
                              watchProductTestProvider.flores[index].imageUrl,
                              width: 130.0,
                              height: 120.0,
                              fit: BoxFit.cover),
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
}
