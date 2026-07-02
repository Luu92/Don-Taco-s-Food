import 'package:flutter/material.dart';

class EstadoPedidoWidget extends StatelessWidget {
  final String estado;

  const EstadoPedidoWidget({
    super.key,
    required this.estado,
  });

  Color obtenerColorEstado() {
    switch (estado) {
      case 'Recibido':
        return Colors.grey;

      case 'En preparación':
        return Colors.orange;

      case 'En camino':
        return Colors.blue;

      case 'Entregado':
        return Colors.green;

      case 'Cancelado':
        return Colors.red;

      default:
        return Colors.black;
    }
  }

  IconData obtenerIconoEstado() {
    switch (estado) {
      case 'Recibido':
        return Icons.receipt_long;

      case 'En preparación':
        return Icons.restaurant;

      case 'En camino':
        return Icons.delivery_dining;

      case 'Entregado':
        return Icons.check_circle;

      case 'Cancelado':
        return Icons.cancel;

      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          obtenerIconoEstado(),
          color: obtenerColorEstado(),
          size: 18,
        ),
        const SizedBox(width: 6),
        Text(
          estado,
          style: TextStyle(
            color: obtenerColorEstado(),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
