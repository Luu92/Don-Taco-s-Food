import 'package:demo_app/core/core.dart';

class ContrasenaActualizadaDialog extends StatelessWidget {
  const ContrasenaActualizadaDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Container(
        width: 68,
        height: 68,
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.12),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.check_circle_outline_rounded,
          size: 36,
          color: Colors.green,
        ),
      ),
      title: const Text(
        'Contraseña actualizada',
        textAlign: TextAlign.center,
      ),
      content: const Text(
        'Tu contraseña fue actualizada '
        'correctamente. Ya puedes iniciar '
        'sesión con tus nuevas credenciales.',
        textAlign: TextAlign.center,
      ),
      actionsPadding: const EdgeInsets.fromLTRB(
        AppSizes.spacingMd,
        0,
        AppSizes.spacingMd,
        AppSizes.spacingMd,
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          height: AppSizes.buttonHeight,
          child: FilledButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Aceptar',
            ),
          ),
        ),
      ],
    );
  }
}
