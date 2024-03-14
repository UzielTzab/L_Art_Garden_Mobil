import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/Services/service_product.dart';
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
  final List<Product> _flowers = [];

  List<Product> get flores => _flowers;

  Future<void> convertAllProducts() async {
    List<Product> products = await getAllProducts();
    for (var product in products) {
      print("Justificar: ");
      print('Nombre: ${product.nombre}, precio: ${product.precio}, ');

      _initializeProducts(
        product.idProducto,
        product.idCategoria,
        product.idInventario,
        product.nombre,
        product.descripcion,
        product.precio,
        product.stock!,
      );
      showAllTestProducts();
    }
  }

  int? findIndex(int index) {
    for (var flower in _flowers) {
      if (flower.idProducto == index) {
        return flower.idProducto;
      }
    }
    // Si no se encuentra ninguna coincidencia, se devuelve null
    return null;
  }

  void showAllTestProducts() {
    for (var flower in _flowers) {
      print(
          "idProducto: ${flower.idProducto} idCategoria ${flower.idCategoria}: idInventario ${flower.idInventario}: nombre:${flower.nombre} descripcion ${flower.descripcion}: precio: ${flower.precio} stock: ${flower.stock} ");
    }
  }

  void _initializeProducts(int idproducto, int idCategoria, int idInvetario,
      String nombre, String descripcion, double precio, int stock) {
    // Simular algunos productos
    _flowers.add(Product(
      idProducto: idproducto,
      idCategoria: idCategoria,
      idInventario: idInvetario,
      nombre: nombre,
      descripcion: descripcion,
      precio: precio,
      stock: stock,
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
  //   _flowers.add(Product(
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
