import 'package:flutter/material.dart';

class CartProvider {
  final int indexFlower;
  final String imageUrl;
  final String description;
  final String type;
  final double price;
  int quantityToBuy;

  CartProvider({
    required this.indexFlower,
    required this.quantityToBuy,
    required this.imageUrl,
    required this.description,
    required this.type,
    required this.price,
  });
}
