import 'dart:convert';
import '../../models/product.dart';

class FakeApiService {
  // Simula uma resposta de API (2 segundos de delay)
  Future<List<Product>> getProducts() async {
    await Future.delayed(const Duration(seconds: 2));

    const String fakeJsonResponse = '''
    [
      {
        "id": "1",
        "name": "Notebook Gamer",
        "description": "Notebook de alta performance para jogos e trabalho pesado.",
        "price": 4500.0,
        "imageUrl": "https://via.placeholder.com/150",
        "favorite": false
      },
      {
        "id": "2",
        "name": "Mouse Sem Fio",
        "description": "Mouse ergonômico com conexão Bluetooth.",
        "price": 150.0,
        "imageUrl": "https://via.placeholder.com/150",
        "favorite": false
      },
      {
        "id": "3",
        "name": "Teclado Mecânico",
        "description": "Teclado mecânico com switches azuis para melhor digitação.",
        "price": 300.0,
        "imageUrl": "https://via.placeholder.com/150",
        "favorite": false
      },
      {
        "id": "4",
        "name": "Monitor Ultrawide",
        "description": "Monitor 29 polegadas ultrawide para maior produtividade.",
        "price": 1200.0,
        "imageUrl": "https://via.placeholder.com/150",
        "favorite": false
      }
    ]
    ''';

    final List<dynamic> decodedJson = json.decode(fakeJsonResponse);
    return decodedJson.map((item) => Product.fromJson(item)).toList();
  }

  Future<void> addProduct(Product product) async {
    await Future.delayed(const Duration(seconds: 1));
    // Simula adição no servidor
  }

  Future<void> updateProduct(Product product) async {
    await Future.delayed(const Duration(seconds: 1));
    // Simula atualização no servidor
  }

  Future<void> deleteProduct(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    // Simula remoção no servidor
  }
}
