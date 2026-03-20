import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/provider/product_provider.dart';
import '../../models/product.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos (Provider)'),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.products.length,
            itemBuilder: (context, index) {
              final Product product = provider.products[index];
              return ListTile(
                title: Text(product.name),
                subtitle: Text('R\$ ${product.price.toStringAsFixed(2)}'),
                trailing: IconButton(
                  icon: Icon(
                    product.favorite ? Icons.star : Icons.star_border,
                    color: product.favorite ? Colors.amber : null,
                  ),
                  onPressed: () {
                    provider.toggleFavorite(index);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}