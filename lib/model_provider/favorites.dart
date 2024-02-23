import 'package:flutter/material.dart';

class FavoriteProvider with ChangeNotifier {
  int _id_Producto = 0;
  int _id_Invetario = 0;
  String _nombre_Producto = "";
  String _descripcion = "";
  int _precio = 0;
  String _imagen_Producto = "";

  int get id_producto => _id_Producto;
  int get id_Invetario => _id_Invetario;
  String get nombre_Producto => _nombre_Producto;
  String get descripcion => _descripcion;
  int get precio => _precio;
  String get imge_Producto => _imagen_Producto;
}

// Future<List<FavoriteProvider>> setDataFavoriteProduct({
//   required int idProducto,
//   required int idInventario,
//   required String nombre,
//   required String descripcion,
//   required int precio,
//   required String imagen,
// }) async {}
