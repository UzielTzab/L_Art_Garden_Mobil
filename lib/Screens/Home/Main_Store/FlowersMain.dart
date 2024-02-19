import 'package:flutter/material.dart';
import '../Main_Store/Custom_Scroll_View.dart';

class FlowerMain extends StatefulWidget {
  const FlowerMain({super.key});

  @override
  State<FlowerMain> createState() => _FlowerMainState();
}

class _FlowerMainState extends State<FlowerMain> {
  static const Color grayColor = Color.fromARGB(255, 128, 128, 128);
  static const Color whiteColor = Color.fromARGB(255, 255, 255, 255);
  static const Color baseColor = Color.fromARGB(255, 242, 173, 83);
  static const Color unselectColor = Color.fromARGB(255, 156, 112, 18);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: Center(
        child: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(
                      1000), // Ajusta el radio de la esquina inferior
                ),
              ),
              title: const Center(
                child: Text(
                  '¿Qué estas buscando?',
                  style: TextStyle(
                      fontSize: 30.0,
                      color: whiteColor,
                      fontFamily: 'flower sun'),
                ),
              ),
              automaticallyImplyLeading: false,
              backgroundColor: Colors.black,
              bottom: PreferredSize(
                preferredSize:
                    Size.fromHeight(MediaQuery.of(context).size.height * 0.05),
                child: Container(
                  decoration: const BoxDecoration(color: baseColor),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4.0), // Ajusta el relleno
                        child: SizedBox(
                          width: 250,
                          height: 45, // Ajusta la altura del TextField
                          child: TextField(
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
                      MediaQuery.of(context).size.height * 0.08),
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
                            fontSize: 17,
                            letterSpacing: 2,
                            fontFamily: 'Capri'),
                        labelColor:
                            baseColor, // Cambia el color del texto de la pestaña activa
                        unselectedLabelColor:
                            unselectColor, // Cambia el color del texto de las pestañas inactivas
                        indicatorColor: baseColor,
                        // Cambia el color del indicador de la pestaña activa
                        tabs: const [
                          Tab(text: 'Ofertas'),
                          Tab(text: 'Ramos'),
                          Tab(text: 'Arreglos'),
                          Tab(text: 'Maceteros'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              body: const TabBarView(
                children: [
                  CustomScrollViewClass(),
                  Placeholder(),
                  Placeholder(),
                  Placeholder()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
