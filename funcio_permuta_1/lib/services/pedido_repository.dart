import 'package:funcio_permuta_1/models/pedido.dart';

class PedidoRepository {
  static final List<Pedido> _pedidos = [];

  static void addPedido(Pedido pedido) {
    _pedidos.add(pedido);
  }

  static List<Pedido> getPedidos() {
    return _pedidos;
  }

  static void clearPedidos() {
    _pedidos.clear();
  }
}
