import 'package:demo_app/models/direccion.dart';
import 'package:flutter/material.dart';

class ConfirmarPedidoDialog extends StatelessWidget {
  final Map<String, Map<String, dynamic>> items;
  final Direccion direccion;
  final double total;
  final String comentario;

  const ConfirmarPedidoDialog({
    super.key,
    required this.items,
    required this.direccion,
    required this.total,
    required this.comentario,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.fact_check_outlined),
          SizedBox(width: 8),
          Expanded(
            child: Text('Confirma tu pedido'),
          ),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Revisa que los alimentos y la dirección sean correctos. '
                'Una vez confirmado, el pedido no podrá modificarse.',
              ),
              const SizedBox(height: 16),
              const Text(
                'Tu pedido',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 8),
              ...items.values.map((item) {
                final cantidad = item['cantidad'] as int;
                final precio = (item['precio'] as num).toDouble();
                final esPastor = item['nombre'] == 'Taco al Pastor';

                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${item['nombre']} x$cantidad',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Subtotal: \$${(precio * cantidad).toStringAsFixed(2)}',
                      ),
                      if (esPastor)
                        Text(
                          'Promoción 2x1: recibirás ${cantidad * 2} tacos',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                );
              }),
              const Divider(),
              Text(
                'Total: \$${total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Dirección de entrega',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                direccion.alias,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text('${direccion.calle} ${direccion.numero}'),
              Text(direccion.colonia),
              Text('CP ${direccion.codigoPostal}'),
              const SizedBox(height: 16),
              const Text(
                'Comentarios',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                comentario.trim().isEmpty
                    ? 'Sin comentarios'
                    : comentario.trim(),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text('Revisar nuevamente'),
        ),
        FilledButton.icon(
          icon: const Icon(Icons.check),
          label: const Text('Confirmar pedido'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }
}
