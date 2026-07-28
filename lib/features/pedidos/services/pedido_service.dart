import 'package:demo_app/core/core.dart';

class PedidoService {
  final List<Pedido> _pedidos = [];

  void guardarPedido(Pedido pedido) {
    _pedidos.add(pedido);
  }

  List<Pedido> obtenerPedidos() {
    return _pedidos;
  }
}
