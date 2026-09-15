import 'package:demo_app/core/core.dart';

class PedidoService {
  final List<Pedido> _pedidos = [];

  void guardarPedido(Pedido pedido) {
    _pedidos.add(pedido);
  }

  List<Pedido> obtenerPedidos() {
    return _pedidos;
  }

  void confirmarEntrega(int idPedido) {
    final index = _pedidos.indexWhere(
      (pedido) => pedido.id == idPedido,
    );

    if (index == -1) {
      return;
    }

    final pedidoActual = _pedidos[index];

    if (pedidoActual.estado != 'En camino') {
      return;
    }

    final pedidoActualizado = Pedido(
      id: pedidoActual.id,
      fecha: pedidoActual.fecha,
      estado: 'Entregado',
      total: pedidoActual.total,
      comentario: pedidoActual.comentario,
      alimentos: pedidoActual.alimentos,
      direccionEntrega: pedidoActual.direccionEntrega,
    );

    _pedidos[index] = pedidoActualizado;
  }
}
