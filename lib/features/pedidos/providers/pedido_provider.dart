import 'package:demo_app/features/pedidos/services/pedido_service.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/models/pedido.dart';

class PedidoProvider extends ChangeNotifier {
  final List<Pedido> _pedidos = [];
  final PedidoService _pedidoService = PedidoService();

  List<Pedido> get pedidos => _pedidos;

  void agregarPedido(Pedido pedido) {
    _pedidos.add(pedido);
    _pedidoService.guardarPedido(pedido);
    notifyListeners();
    print("ESTO ES UN PEDIDO:  $_pedidos");
  }
}
