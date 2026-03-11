import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/cart_repository.dart';
import '../core/app_colors.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/Capa_1.png',
          height: 40,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  product.imageUrl,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),

              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 10),

              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                product.description.isNotEmpty
                    ? product.description
                    : 'Sin descripción disponible.',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {
                  CartRepository.addToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.name} añadido al carrito'),
                      backgroundColor: AppColors.button,
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.button),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                child: const Text(
                  'Añadir al carrito',
                  style: TextStyle(fontSize: 18),
                ),
              )



            ],
          ),
        ),
      ),
    );
  }
}
