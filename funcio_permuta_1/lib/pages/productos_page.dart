import 'package:flutter/material.dart';
import 'package:funcio_permuta_1/pages/search_page.dart';
import '../services/product_repository.dart';
import '../models/product.dart';
import '../widgets/custom_app_bar.dart';
import 'product_detail_page.dart';


class ProductosPage extends StatefulWidget {
  const ProductosPage({super.key});

  @override
  State<ProductosPage> createState() => _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {
  String selectedCategory = 'Skin Care';
  final List<String> categories = ['Hair Care', 'Skin Care', 'Body Care'];

  @override
  Widget build(BuildContext context) {
    // Filtra los productos según la categoría seleccionada
    final List<Product> filteredProducts =
    ProductRepository.getByCategory(selectedCategory);

    return Scaffold(
      appBar: CustomAppBar(
        onSearchTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SearchPage()),
          );
        },
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey.shade100,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: categories.map((cat) {
                final isSelected = selectedCategory == cat;
                return GestureDetector(
                  onTap: () => setState(() => selectedCategory = cat),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blueAccent : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.blueAccent),
                    ),
                    child: Text(
                      cat,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 productos por fila
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailPage(product: product),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius:
                            const BorderRadius.vertical(top: Radius.circular(12)),
                            child: Image.asset(
                              product.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
