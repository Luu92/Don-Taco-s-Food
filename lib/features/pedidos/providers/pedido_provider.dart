import 'package:demo_app/core/core.dart';

class PedidoProvider extends ChangeNotifier {
  final List<Pedido> _pedidos = [];
  final PedidoService _pedidoService = PedidoService();

  List<Pedido> get pedidos => _pedidos;

  void agregarPedido(Pedido pedido) {
    _pedidos.add(pedido);
    _pedidoService.guardarPedido(pedido);
    notifyListeners();
  }

  void limpiar() {
    pedidos.clear();
    notifyListeners();
  }
}
