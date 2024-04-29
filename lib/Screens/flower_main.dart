import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/Models/flower_shops.dart';
import 'package:l_art_garden_mobil/Services/services_flower_shops.dart';
import 'package:l_art_garden_mobil/Widgets/app_bar_oval.dart';
import 'package:l_art_garden_mobil/Widgets/example_parallax.dart';
import 'package:l_art_garden_mobil/model_provider/flower_shops_provider.dart';
import 'package:l_art_garden_mobil/model_provider/text_filter_products.dart';
import 'package:provider/provider.dart';
import 'list_offers.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class FlowerMain extends StatefulWidget {
  const FlowerMain({super.key});

  @override
  State<FlowerMain> createState() => _FlowerMainState();
}

class _FlowerMainState extends State<FlowerMain> {
  static const Color grayColor = Color.fromARGB(255, 128, 128, 128);
  static const Color whiteColor = Color.fromARGB(255, 255, 255, 255);
  static const Color shimmerColor = Color.fromARGB(255, 255, 248, 239);
  static const Color baseColor = Color.fromARGB(255, 242, 173, 83);
  static const Color unselectColor = Color.fromARGB(255, 156, 112, 18);

  @override
  void initState() {
    super.initState();
    loadFlowerShops();
  }

  Future<void> loadFlowerShops() async {
    var flowerShopProvider =
        Provider.of<FlowerShopProvider>(context, listen: false);
    var flowerShops = await getAllFlowerShops();
    flowerShops.forEach((shop) {
      print(
          'Florería: ${shop.nombreFloreria}, ID de inventario: ${shop.idFloreria}');
    });

    if (mounted) {
      setState(() {
        flowerShopProvider.flowerShops = flowerShops;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: Center(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              flexibleSpace: CustomFlexibleSpace(),
              toolbarHeight: MediaQuery.of(context).size.height * 0.1,
              title: SizedBox(
                width:
                    250.0, // Ajusta este valor para que se adapte a tus necesidades
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 30.0,
                    color: whiteColor,
                    fontFamily: 'FlowerLetter',
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText('¿Qué estas buscando?',
                          speed: Duration(milliseconds: 100)),
                      TyperAnimatedText('¿Flores?',
                          speed: Duration(milliseconds: 100)),
                      TyperAnimatedText('¿Arreglos?',
                          speed: Duration(milliseconds: 100)),
                      TyperAnimatedText('¡Buscalo aqui!',
                          speed: Duration(milliseconds: 100)),
                    ],
                    isRepeatingAnimation:
                        true, // La animación se ejecuta una sola vez
                  ),
                ),
              ),
              automaticallyImplyLeading: false,
              backgroundColor: baseColor.withAlpha(1),
              bottom: PreferredSize(
                preferredSize:
                    Size.fromHeight(MediaQuery.of(context).size.height * 0.05),
                child: Container(
                  decoration: BoxDecoration(color: baseColor.withAlpha(0)),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: 15,
                            right: MediaQuery.of(context).size.width * 0.2),
                        child: SizedBox(
                          width: 240,
                          height: 43, // Ajusta la altura del TextField
                          child: TextField(
                            onChanged: (text) {
                              Provider.of<SearchProvider>(context,
                                      listen: false)
                                  .setSearchText(text);
                            },
                            style: const TextStyle(color: grayColor),
                            decoration: InputDecoration(
                              labelStyle: const TextStyle(color: grayColor),
                              filled: true,
                              fillColor: whiteColor,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              hintText: 'Search...',
                              prefixIcon: const Icon(
                                Icons.search,
                                color: grayColor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: BorderSide(color: whiteColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: BorderSide(color: whiteColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: Scaffold(
              appBar: AppBar(
                toolbarHeight: MediaQuery.of(context).size.height * 0.00,
                automaticallyImplyLeading:
                    false, // Esto elimina el botón de retroceso
                backgroundColor: whiteColor,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(
                      MediaQuery.of(context).size.height * 0.07),
                  child: Column(
                    children: [
                      TabBar(
                        indicator: BoxDecoration(
                          // border: Border.all(color: baseColor),
                          color: baseColor,
                          borderRadius: BorderRadius.circular(9),
                        ),
                        indicatorSize: TabBarIndicatorSize
                            .tab, // Ajusta el tamaño del indicador
                        indicatorPadding: const EdgeInsets.only(top: 45),
                        labelStyle: const TextStyle(
                            fontSize: 12,
                            letterSpacing: 2,
                            fontFamily: 'Capri'),
                        labelColor:
                            baseColor, // Cambia el color del texto de la pestaña activa
                        unselectedLabelColor:
                            unselectColor, // Cambia el color del texto de las pestañas inactivas
                        indicatorColor: baseColor,
                        // Cambia el color del indicador de la pestaña activa
                        tabs: const [
                          Tab(text: 'Flores y Arreglos'),
                          Tab(text: 'Florerias en Yucatan'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              body: Container(
                color: shimmerColor,
                child: TabBarView(
                  children: [
                    CustomListOffers(),
                    Consumer<FlowerShopProvider>(
                      builder: (context, flowerShopProvider, child) {
                        if (flowerShopProvider.flowerShops.isEmpty) {
                          getAllFlowerShops().then((flowerShops) {
                            flowerShopProvider.flowerShops = flowerShops;
                          });
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return FlowerShopsParallax(
                              flowerShops: flowerShopProvider.flowerShops);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
