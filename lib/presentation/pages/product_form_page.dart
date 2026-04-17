import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../models/product.dart';
import '../../state/provider/product_provider.dart';

class ProductFormPage extends StatefulWidget {
  final Product? product; // Se for nulo, é criação. Se tiver dado, é edição.

  const ProductFormPage({super.key, this.product});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _uuid = const Uuid();

  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageUrlController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product?.name ?? '');
    _priceController =
        TextEditingController(text: widget.product?.price.toString() ?? '');
    _descriptionController =
        TextEditingController(text: widget.product?.description ?? '');
    _imageUrlController =
        TextEditingController(text: widget.product?.imageUrl ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final String id = widget.product?.id ?? _uuid.v4();
      final double price = double.tryParse(_priceController.text) ?? 0.0;

      final newProduct = Product(
        id: id,
        name: _nameController.text,
        description: _descriptionController.text,
        price: price,
        imageUrl: _imageUrlController.text,
        favorite: widget.product?.favorite ?? false,
      );

      final provider = Provider.of<ProductProvider>(context, listen: false);

      if (widget.product == null) {
        provider.addProduct(newProduct);
      } else {
        provider.updateProduct(newProduct);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.product != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Produto' : 'Novo Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome do Produto'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Insira um nome válido.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Preço'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null ||
                      double.tryParse(value) == null ||
                      double.parse(value) <= 0) {
                    return 'Insira um preço válido maior que zero.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descrição'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Insira uma descrição.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'URL da Imagem'),
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveForm,
                child: Text(isEditing ? 'Atualizar' : 'Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
