import 'package:flutter/material.dart';
import 'package:funcio_permuta_1/pages/search_page.dart';
import '../models/user.dart';
import '../services/cart_repository.dart';
import '../core/app_colors.dart';
import '../widgets/custom_app_bar.dart';
import 'chekout_page.dart';

class CarritoPage extends StatefulWidget {
  final User user;

  const CarritoPage({super.key,required this.user});

  @override
  State<CarritoPage> createState() => _CarritoPageState();
}

class _CarritoPageState extends State<CarritoPage> {
  @override
  Widget build(BuildContext context) {
    final cart = CartRepository.getCart();

    return Scaffold(
      appBar: CustomAppBar(
        onSearchTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SearchPage()),
          );
        },
      ),
      body: cart.isEmpty
          ? const Center(child: Text('Tu carrito está vacío'))
          : Column(
        children: [
          Expanded(
            child: ListView(
              children: cart.entries.map((entry) {
                final product = entry.key;
                final qty = entry.value;
                final subtotal = product.price * qty;

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 📸 Imagen del producto
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            product.imageUrl,
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),

                        // 📄 Info del producto
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 16)),
                              const SizedBox(height: 6),
                              Text('\$${product.price.toStringAsFixed(2)} c/u',
                                  style: const TextStyle(color: Colors.grey)),
                              const SizedBox(height: 6),
                              Text('Subtotal: \$${subtotal.toStringAsFixed(2)}'),
                            ],
                          ),
                        ),

                        //  botones
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                setState(() {
                                  CartRepository.updateQuantity(product, qty - 1);
                                });
                              },
                            ),
                            Text('$qty'),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () {
                                setState(() {
                                  CartRepository.updateQuantity(product, qty + 1);
                                });
                              },
                            ),
                            // eliminar producto
                            IconButton(
                              icon: const Icon(Icons.close, color: Colors.redAccent),
                              onPressed: () {
                                setState(() {
                                  CartRepository.removeFromCart(product);
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          // 💰 Total
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: const Border(top: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: \$${CartRepository.getTotalPrice().toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutPage(user: widget.user),
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
                        borderRadius: BorderRadius.circular(30), // bordes redondeados
                      ),
                    ),
                  ),
                  child: const Text(
                    'Pagar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

