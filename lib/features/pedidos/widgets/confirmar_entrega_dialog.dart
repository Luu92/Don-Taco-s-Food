import 'package:demo_app/core/core.dart';

class ConfirmarEntregaDialog extends StatelessWidget {
  const ConfirmarEntregaDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Container(
        width: 68,
        height: 68,
        decoration: BoxDecoration(
          color: AppColors.secondary.withOpacity(0.14),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.check_circle_outline_rounded,
          size: 36,
          color: AppColors.primary,
        ),
      ),
      title: const Text(
        '¿Recibiste tu pedido?',
        textAlign: TextAlign.center,
      ),
      content: const Text(
        'Confirma únicamente cuando el pedido '
        'haya sido entregado en tu domicilio. '
        'Esta acción no se puede deshacer.',
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text(
            'Cancelar',
          ),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: const Text(
            'Sí, lo recibí',
          ),
        ),
      ],
    );
  }
}
