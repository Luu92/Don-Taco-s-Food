import 'package:demo_app/core/core.dart';

class DireccionFueraCoberturaDialog extends StatelessWidget {
  const DireccionFueraCoberturaDialog({
    super.key,
    required this.codigoPostal,
  });

  final String codigoPostal;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(
        Icons.location_off_outlined,
        color: Colors.orange,
        size: 56,
      ),
      title: const Text(
        'Dirección fuera de cobertura',
        textAlign: TextAlign.center,
      ),
      content: Text(
        'Por el momento, el servicio a domicilio no está disponible '
        'para el código postal $codigoPostal.',
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        FilledButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Entendido'),
        ),
      ],
    );
  }
}
