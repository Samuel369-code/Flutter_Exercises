import 'package:flutter/material.dart';
import 'package:funcio_permuta_1/pages/search_page.dart';
import '../services/pedido_repository.dart';
import '../models/pedido.dart';
import '../models/product.dart';
import '../widgets/custom_app_bar.dart';

class HistorialPage extends StatelessWidget {
  const HistorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pedidos = PedidoRepository.getPedidos();

    return Scaffold(
      appBar: CustomAppBar(
        onSearchTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SearchPage()),
          );
        },
      ),
      body: pedidos.isEmpty
          ? const Center(child: Text('No tienes pedidos aún'))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: pedidos.length,
        itemBuilder: (context, index) {
          final pedido = pedidos[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pedido Nº ${pedido.idPedido}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 130,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: pedido.productos.length,
                  itemBuilder: (context, i) {
                    final item = pedido.productos[i];
                    final Product producto = item['producto'];
                    final int cantidad = item['cantidad'];

                    return Container(
                      width: 110,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            producto.imageUrl,
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            producto.name,
                            style: const TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text('x$cantidad'),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Divider(color: Colors.grey[300]),
              const SizedBox(height: 12),
            ],
          );
        },
      ),
    );
  }
}
