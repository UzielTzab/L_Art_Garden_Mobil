import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/AnimationRoutes/routeAnimatedBottomToTop.dart';
import 'package:l_art_garden_mobil/Models/product.dart';
import 'package:l_art_garden_mobil/Services/service_product.dart';
import 'package:l_art_garden_mobil/model_provider/products_provider.dart';
import 'package:l_art_garden_mobil/model_provider/text_filter_products.dart';
import 'package:provider/provider.dart';
import 'carousel_flower_shops.dart';
import 'product_screee.dart';
import 'package:shimmer/shimmer.dart';

class CustomListOffers extends StatefulWidget {
  const CustomListOffers({Key? key}) : super(key: key);

  @override
  _CustomListOffersState createState() => _CustomListOffersState();
}

class _CustomListOffersState extends State<CustomListOffers> {
  static const List<String> list = <String>["Rojo", "Blanco", "Morado", "Azul"];
  String dropdownValue = list.first;

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<ProductProvider>(context, listen: false).fetchProducts());
  }

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductProvider>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider watchProductProvider = context.watch<ProductProvider>();
    SearchProvider searchProvider = context.watch<SearchProvider>();

    List<Product> products = searchProvider
        .filterProducts(watchProductProvider.products); // Filtra los productos

    return RefreshIndicator(
      onRefresh: () => _refreshProducts(context),
      child: CustomScrollView(
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
                mainAxisExtent: 300.0,
                childAspectRatio: 0.6),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (products.isEmpty) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                } else {
                  return Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 180,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255)),
                          child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                    PageRoutesFree.createPageRoute(
                                        ProductScreen(
                                            products[index].idProducto)));
                              },
                              child: products[index].imagen1 != ''
                                  ? Image.network(
                                      products[index].imagen1,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      'https://floresfinas.oss-us-east-1.aliyuncs.com/mj-v1/arreglo-floral-m4067-1.webp')),
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
                                  products[index].nombre,
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
                                      '${products[index].precio.toString()} MXN',
                                      style: const TextStyle(
                                          fontFamily: "Arial",
                                          fontSize: 20,
                                          color: Color.fromARGB(
                                              255, 209, 137, 49)),
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
                }
              },
              childCount: products.isEmpty
                  ? 10
                  : products.length, // Usa la longitud de la lista filtrada
            ),
          ),
        ],
      ),
    );
  }
}
