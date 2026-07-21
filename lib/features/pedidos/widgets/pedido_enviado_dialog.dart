import 'package:flutter/material.dart';

enum AccionPedidoEnviado {
  verPedidos,
  seguirComprando,
}

class PedidoEnviadoDialog extends StatelessWidget {
  final int? numeroPedido;

  const PedidoEnviadoDialog({
    super.key,
    this.numeroPedido,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(
        Icons.check_circle,
        color: Colors.green,
        size: 64,
      ),
      title: const Text(
        '¡Pedido enviado!',
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Tu pedido fue recibido correctamente por la taquería.',
            textAlign: TextAlign.center,
          ),
          if (numeroPedido != null) ...[
            const SizedBox(height: 10),
            Text(
              'Número de pedido: #$numeroPedido',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.receipt_long_outlined,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      '¿Dónde puedo consultarlo?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'Puedes revisar el estado de tu pedido desde la sección '
                  '"Mis pedidos".',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(
              context,
              AccionPedidoEnviado.seguirComprando,
            );
          },
          child: const Text('Seguir comprando'),
        ),
        FilledButton.icon(
          onPressed: () {
            Navigator.pop(
              context,
              AccionPedidoEnviado.verPedidos,
            );
          },
          icon: const Icon(Icons.receipt_long),
          label: const Text('Ver mis pedidos'),
        ),
      ],
    );
  }
}
