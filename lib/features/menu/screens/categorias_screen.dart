import 'package:demo_app/core/core.dart';

class CategoriasScreen extends StatelessWidget {
  const CategoriasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categorias = CategoriaService().obtenerCategorias();
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/img/logo2.png',
              width: 60,
              height: 42,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: AppSizes.spacingSm),
            const Text("Don Taco's"),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(
            AppSizes.spacingMd,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '¿Qué vas a ordenar hoy?',
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(
                height: AppSizes.spacingXs,
              ),
              Text(
                'Selecciona una categoría para comenzar.',
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(
                height: AppSizes.spacingMd,
              ),

              // Aviso de pago en efectivo
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(
                  AppSizes.spacingMd,
                ),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(
                    AppSizes.radiusMedium,
                  ),
                  border: Border.all(
                    color: AppColors.secondary.withOpacity(0.55),
                  ),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.payments_outlined,
                      size: 28,
                      color: AppColors.primary,
                    ),
                    SizedBox(
                      width: AppSizes.spacingMd,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Forma de pago',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(
                            height: AppSizes.spacingXs,
                          ),
                          Text(
                            'El pago se realizará en efectivo al momento '
                            'de recibir tu pedido. De ser posible, prepara '
                            'el monto exacto.',
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.35,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: AppSizes.spacingLg,
              ),

              Text(
                'Categorías',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(
                height: AppSizes.spacingMd,
              ),

              Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: AppSizes.spacingMd,
                    mainAxisSpacing: AppSizes.spacingMd,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: categorias.length,
                  itemBuilder: (context, index) {
                    final categoria = categorias[index];

                    return Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppSizes.radiusLarge,
                        ),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(
                          AppSizes.radiusLarge,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MainContainer(
                                categoriaInicial: categoria,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(
                            AppSizes.spacingMd,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    AppSizes.radiusMedium,
                                  ),
                                  child: Image.asset(
                                    categoria.imagen,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: AppSizes.spacingMd,
                              ),
                              Text(
                                categoria.nombre,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(
                                height: AppSizes.spacingXs,
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Ver alimentos',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 17,
                                    color: AppColors.primary,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
