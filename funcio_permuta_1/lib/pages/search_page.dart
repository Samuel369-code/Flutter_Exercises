import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_repository.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<Product> _filtered = ProductRepository.products;

  void _filter(String query) {
    setState(() {
      _filtered = ProductRepository.products
          .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar productos'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Buscar...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _filter,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filtered.length,
              itemBuilder: (context, i) {
                final p = _filtered[i];
                return ListTile(
                  title: Text(p.name),
                  subtitle: Text('${p.price.toStringAsFixed(2)} €'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
