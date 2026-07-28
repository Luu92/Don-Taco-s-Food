import 'package:demo_app/core/core.dart';

class DireccionesVacias extends StatelessWidget {
  const DireccionesVacias({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(
          AppSizes.spacingLg,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: const Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 82,
                    color: AppColors.primary,
                  ),
                  Positioned(
                    right: 27,
                    bottom: 28,
                    child: CircleAvatar(
                      radius: 19,
                      backgroundColor: AppColors.surface,
                      child: Icon(
                        Icons.add_rounded,
                        size: 24,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: AppSizes.spacingLg,
            ),
            Text(
              'No tienes direcciones registradas',
              textAlign: TextAlign.center,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(
              height: AppSizes.spacingSm,
            ),
            Text(
              'Agrega una dirección de entrega para poder '
              'realizar y recibir tus pedidos.',
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge?.copyWith(
                height: 1.5,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(
              height: AppSizes.spacingXl,
            ),
            SizedBox(
              width: double.infinity,
              height: AppSizes.buttonHeight,
              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.add_location_alt_outlined,
                ),
                label: const Text(
                  'Agregar dirección',
                ),
                onPressed: () async {
                  await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AgregarDireccionScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
