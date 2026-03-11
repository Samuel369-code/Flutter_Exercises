import 'package:flutter/material.dart';
import '../models/pedido.dart';
import '../services/cart_repository.dart';
import '../core/app_colors.dart';
import '../models/user.dart';
import '../services/pedido_repository.dart'; // Asegúrate de tener este modelo

class CheckoutPage extends StatefulWidget {
  final User user; // Recibimos el usuario del login

  const CheckoutPage({super.key, required this.user});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: widget.user.phone ?? '');
    _addressController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = CartRepository.getCart(); // Map<Product, int>
    final subtotal = CartRepository.getTotalPrice();
    const double shippingCost = 5.0;
    final total = subtotal + shippingCost;
    final entries = cart.entries.toList();

    return Scaffold(
      // AppBar transparente con título "Checkout"
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      extendBodyBehindAppBar: true, // para que el fondo se vea detrás del AppBar
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login-checkout_bg_img.png'),
            fit: BoxFit.cover,
            opacity: 0.15,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // 🧺 Lista de productos
              Expanded(
                child: entries.isEmpty
                    ? const Center(child: Text('Tu carrito está vacío'))
                    : ListView.builder(
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    final entry = entries[index];
                    final product = entry.key;
                    final quantity = entry.value;

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            product.imageUrl,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(product.name),
                        subtitle: Text(
                          '$quantity × \$${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        trailing: Text(
                          '\$${(product.price * quantity).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Datos de envío',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Teléfono
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Teléfono',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 12),

                    // Dirección
                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(
                        labelText: 'Dirección',
                        prefixIcon: Icon(Icons.location_on),
                        border: OutlineInputBorder(),
                        hintText: 'Introduce tu dirección de entrega',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Resumen de precios y botón
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildPriceRow('Subtotal', subtotal),
                    const SizedBox(height: 8),
                    _buildPriceRow('Gastos de envío', shippingCost),
                    const Divider(height: 24, thickness: 1),
                    _buildPriceRow('Total', total, isTotal: true),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_addressController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Por favor, introduce tu dirección')),
                            );
                            return;
                          }

                          final pedidoId = 'P${DateTime.now().millisecondsSinceEpoch}';

                          final cart = CartRepository.getCart();

                          final productos = cart.entries.map((e) => {
                            'producto': e.key,
                            'cantidad': e.value,
                          }).toList();

                          final pedido = Pedido(
                            idPedido: pedidoId,
                            productos: productos,
                            total: CartRepository.getTotalPrice() + 5.0,
                            fecha: DateTime.now(),
                          );

                          PedidoRepository.addPedido(pedido);

                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Compra realizada'),
                              content: Text(
                                '¡Gracias por tu compra!\n\n'
                                    'Pedido: $pedidoId\n'
                                    'Teléfono: ${_phoneController.text}\n'
                                    'Dirección: ${_addressController.text}\n\n'
                                    'Tu pedido está en proceso.',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    CartRepository.clearCart();
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Aceptar'),
                                ),
                              ],
                            ),
                          );
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.button,
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Comprar ahora',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.black : Colors.grey[700],
          ),
        ),
      ],
    );
  }
}

