import 'package:flutter/material.dart';

class MontoMinimoDialog extends StatelessWidget {
  final double montoMinimo;

  const MontoMinimoDialog({
    super.key,
    this.montoMinimo = 200,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(
        Icons.delivery_dining_outlined,
        size: 58,
        color: Colors.orange,
      ),
      title: const Text(
        'Monto mínimo de compra',
        textAlign: TextAlign.center,
      ),
      content: Text(
        'El monto mínimo para solicitar servicio a domicilio es de '
        '\$${montoMinimo.toStringAsFixed(0)}.\n\n'
        'para continuar con el pedido.',
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        FilledButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Seguir comprando'),
        ),
      ],
    );
  }
}
