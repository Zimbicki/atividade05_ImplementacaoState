import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../data/services/fake_api_service.dart';

class ProductProvider extends ChangeNotifier {
  final FakeApiService _apiService = FakeApiService();
  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  ProductProvider() {
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _apiService.getProducts();
    } catch (e) {
      _products = [];
      // Handle the error simply here for this mock
      print('Erro ao carregar produtos: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void toggleFavorite(int index) {
    if (index >= 0 && index < _products.length) {
      _products[index].favorite = !_products[index].favorite;
      notifyListeners();
    }
  }

  // Create
  Future<void> addProduct(Product product) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _apiService.addProduct(product);
      _products.add(product);
    } catch (e) {
      print('Erro ao adicionar produto: \$e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Update
  Future<void> updateProduct(Product product) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _apiService.updateProduct(product);
      final index = _products.indexWhere((p) => p.id == product.id);
      if (index != -1) {
        _products[index] = product;
      }
    } catch (e) {
      print('Erro ao atualizar: \$e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Delete
  Future<void> deleteProduct(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _apiService.deleteProduct(id);
      _products.removeWhere((p) => p.id == id);
    } catch (e) {
      print('Erro ao excluir: \$e');
    }

    _isLoading = false;
    notifyListeners();
  }
}