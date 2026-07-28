import 'package:demo_app/core/core.dart';

class PedidosVacios extends StatelessWidget {
  const PedidosVacios({super.key});

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
                    Icons.receipt_long_outlined,
                    size: 82,
                    color: AppColors.primary,
                  ),
                  Positioned(
                    right: 30,
                    bottom: 32,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: AppColors.surface,
                      child: Icon(
                        Icons.restaurant_menu_rounded,
                        size: 20,
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
              'Aún no tienes pedidos',
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
              'Cuando realices tu primer pedido, podrás '
              'consultar aquí su estado y todos sus detalles.',
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
                  Icons.restaurant_menu_rounded,
                ),
                label: const Text(
                  'Realizar un pedido',
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CategoriasScreen(),
                    ),
                    (route) => false,
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
