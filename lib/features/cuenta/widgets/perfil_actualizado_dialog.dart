import 'package:flutter/material.dart';

class PerfilActualizadoDialog extends StatelessWidget {
  const PerfilActualizadoDialog({
    super.key,
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
        'Perfil actualizado',
        textAlign: TextAlign.center,
      ),
      content: const Text(
        'Tus datos personales se actualizaron correctamente.',
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        FilledButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}
