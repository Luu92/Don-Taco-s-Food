import 'package:demo_app/core/core.dart';

class CarritoVacio extends StatelessWidget {
  const CarritoVacio({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Center(
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
                child: const Icon(
                  Icons.sentiment_very_dissatisfied,
                  size: 82,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(
                height: AppSizes.spacingLg,
              ),
              Text(
                'Tu carrito está vacío',
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
                'Todavía no has agregado alimentos.\n'
                'Explora nuestro menú y elige tus favoritos.',
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
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CategoriasScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  icon: const Icon(
                    Icons.restaurant_menu_rounded,
                  ),
                  label: const Text(
                    'Explorar menú',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
