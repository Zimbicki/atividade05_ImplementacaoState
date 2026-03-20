import 'package:flutter/material.dart';
import '../../models/product.dart';

class ProductProvider extends ChangeNotifier {
  final List<Product> _products = [
    Product(name: 'Notebook', price: 3500.0),
    Product(name: 'Mouse', price: 120.0),
    Product(name: 'Teclado', price: 250.0),
    Product(name: 'Monitor', price: 900.0),
  ];

  List<Product> get products => _products;

  void toggleFavorite(int index) {
    _products[index].favorite = !_products[index].favorite;
    notifyListeners();
  }
}