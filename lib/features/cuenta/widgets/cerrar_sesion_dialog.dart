import 'package:demo_app/core/core.dart';

class CerrarSesionDialog extends StatelessWidget {
  const CerrarSesionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: AppColors.secondary.withOpacity(0.14),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.logout_rounded,
          size: 32,
          color: AppColors.primary,
        ),
      ),
      title: const Text(
        'Cerrar sesión',
        textAlign: TextAlign.center,
      ),
      content: const Text(
        '¿Estás seguro de que deseas cerrar tu sesión?',
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
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text('Cerrar sesión'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
