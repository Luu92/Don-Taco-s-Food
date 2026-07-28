import 'package:demo_app/core/core.dart';

class EliminarDireccionDialog extends StatelessWidget {
  final String alias;

  const EliminarDireccionDialog({
    super.key,
    required this.alias,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.10),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.delete_outline_rounded,
          size: 32,
          color: Colors.red,
        ),
      ),
      title: const Text(
        'Eliminar dirección',
        textAlign: TextAlign.center,
      ),
      content: Text(
        '¿Estás seguro de que deseas eliminar la dirección "$alias"?',
        textAlign: TextAlign.center,
      ),
      actionsPadding: const EdgeInsets.fromLTRB(
        AppSizes.spacingMd,
        0,
        AppSizes.spacingMd,
        AppSizes.spacingMd,
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text('Cancelar'),
              ),
            ),
            const SizedBox(
              width: AppSizes.spacingSm,
            ),
            Expanded(
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text('Eliminar'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
