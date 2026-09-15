import 'package:demo_app/core/core.dart';

class PedidoProvider extends ChangeNotifier {
  List<Pedido> _pedidos = [];

  final PedidoService _pedidoService = PedidoService();

  List<Pedido> get pedidos => _pedidos;

  void agregarPedido(Pedido pedido) {
    _pedidoService.guardarPedido(pedido);

    _pedidos = _pedidoService.obtenerPedidos();

    notifyListeners();
  }

  void confirmarEntrega(int idPedido) {
    _pedidoService.confirmarEntrega(idPedido);

    _pedidos = _pedidoService.obtenerPedidos();

    notifyListeners();
  }

  void limpiar() {
    _pedidos.clear();
    notifyListeners();
  }
}
