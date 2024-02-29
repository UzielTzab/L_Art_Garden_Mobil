import 'package:flutter/material.dart';
import '../Models/product.dart';

class ProductsTestProvider with ChangeNotifier {
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
  final List<Flower> _flowers = [];

  List<Flower> get flores => _flowers;

  ProductsTestProvider() {
    // Crear algunos productos simulados al inicializar la clase
    _initializeProducts();
  }

  int? findIndex(int index) {
    for (var flower in _flowers) {
      if (flower.indexFlower == index) {
        return flower.indexFlower;
      }
    }
    // Si no se encuentra ninguna coincidencia, se devuelve null
    return null;
  }

  void _initializeProducts() {
    // Simular algunos productos
    _flowers.add(Flower(
      indexFlower: 0,
      imageUrl: imageUrls[0],
      descripcion: 'Ramo de rosas especiales',
      precio: 500,
      tipo: 'Ramo',
      stock: 10,
    ));

    _flowers.add(Flower(
      indexFlower: 1,
      imageUrl: imageUrls[1],
      descripcion: 'Arreglo floral, rosas blancas y rosadas',
      precio: 300,
      tipo: 'Arreglo',
      stock: 5,
    ));

    _flowers.add(Flower(
      indexFlower: 2,
      imageUrl: imageUrls[2],
      descripcion: 'Arreglo floral, rosas rosadas',
      precio: 350,
      tipo: 'Arreglo',
      stock: 8,
    ));

    _flowers.add(Flower(
      indexFlower: 3,
      imageUrl: imageUrls[3],
      descripcion: 'Arreglo de caja rectangular, con rosas nativas coloridas',
      precio: 440,
      tipo: 'Arreglo',
      stock: 19,
    ));
    _flowers.add(Flower(
      indexFlower: 4,
      imageUrl: imageUrls[4],
      descripcion: 'Arreglo de rosa blanca especial ',
      precio: 800,
      tipo: 'Arreglo',
      stock: 12,
    ));

    _flowers.add(Flower(
      indexFlower: 5,
      imageUrl: imageUrls[5],
      descripcion: 'Arreglo de flores de temporada ',
      precio: 600,
      tipo: 'Arreglo',
      stock: 2,
    ));
    _flowers.add(Flower(
      indexFlower: 6,
      imageUrl: imageUrls[6],
      descripcion: 'Arreglo de rosa especial con chocolates incluidos ',
      precio: 1050,
      tipo: 'Arreglo',
      stock: 4,
    ));

    // Agregar más productos según sea necesario
  }

  List<String> GetUrl() {
    return imageUrls;
  }

  // void addFlower(
  //     {required int indexFlower,
  //     required String imageUrl,
  //     required String descripcion,
  //     required int precio,
  //     required String tipo,
  //     required int stock}) {
  //   _flowers.add(Flower(
  //     indexFlower: indexFlower,
  //     imageUrl: imageUrl,
  //     descripcion: descripcion,
  //     precio: precio,
  //     tipo: tipo,
  //     stock: stock,
  //   ));
  //   notifyListeners();
  // }
}
