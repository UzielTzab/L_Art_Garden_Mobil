import 'package:flutter/material.dart';

class CartMain extends StatefulWidget {
  final List<int> indices;

  const CartMain({Key? key, required this.indices}) : super(key: key);

  @override
  State<CartMain> createState() => _CartMainState();
}

class _CartMainState extends State<CartMain> {
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Carrito'),
      ),
      body: ListView.builder(
        itemCount: widget.indices.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                title: const Text('Dolor Im pusilanime'),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(imageUrls[index]),
                ),
              ),
              const Divider(
                // Agregar un Divider entre cada ListTile
                color: Colors.grey, // Color del separador
                thickness: 1, // Grosor del separador
              ),
            ],
          );
        },
      ),
      bottomSheet: Container(
        color: Colors.amber,
        height: MediaQuery.of(context).size.height / 8,
        width: MediaQuery.of(context).size.width,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [Text('Precio total:'), Text('Cantidad de productos:')],
        ),
      ),
    );
  }
}
