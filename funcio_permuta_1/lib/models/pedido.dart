
class Pedido {
  final String idPedido;
  final List<Map<String, dynamic>> productos; // [{producto: Product, cantidad: 2}, ...]
  final double total;
  final DateTime fecha;

  Pedido({
    required this.idPedido,
    required this.productos,
    required this.total,
    required this.fecha,
  });
}
