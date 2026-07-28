import 'package:demo_app/core/core.dart';

class DireccionesScreen extends StatelessWidget {
  const DireccionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final direccionProvider = context.watch<DireccionProvider>();
    final direcciones = direccionProvider.direcciones;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis direcciones'),
      ),
      body: SafeArea(
        child: direcciones.isEmpty
            ? const DireccionesVacias()
            : ListView.separated(
                padding: const EdgeInsets.fromLTRB(
                  AppSizes.spacingMd,
                  AppSizes.spacingMd,
                  AppSizes.spacingMd,
                  100,
                ),
                itemCount: direcciones.length,
                separatorBuilder: (_, __) => const SizedBox(
                  height: AppSizes.spacingMd,
                ),
                itemBuilder: (context, index) {
                  final direccion = direcciones[index];

                  return Card(
                    margin: EdgeInsets.zero,
                    clipBehavior: Clip.antiAlias,
                    child: Padding(
                      padding: const EdgeInsets.all(
                        AppSizes.spacingMd,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: direccion.principal
                                  ? AppColors.secondary.withOpacity(0.18)
                                  : AppColors.background,
                              borderRadius: BorderRadius.circular(
                                AppSizes.radiusMedium,
                              ),
                              border: Border.all(
                                color: direccion.principal
                                    ? AppColors.secondary.withOpacity(0.55)
                                    : AppColors.border,
                              ),
                            ),
                            child: Icon(
                              direccion.principal
                                  ? Icons.home_rounded
                                  : Icons.location_on_outlined,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(
                            width: AppSizes.spacingMd,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        direccion.alias,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ),
                                    if (direccion.principal)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: AppSizes.spacingSm,
                                          vertical: AppSizes.spacingXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.secondary
                                              .withOpacity(0.16),
                                          borderRadius: BorderRadius.circular(
                                            AppSizes.radiusLarge,
                                          ),
                                        ),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.star_rounded,
                                              size: 16,
                                              color: AppColors.primary,
                                            ),
                                            SizedBox(
                                              width: AppSizes.spacingXs,
                                            ),
                                            Text(
                                              'Principal',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.textPrimary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(
                                  height: AppSizes.spacingSm,
                                ),
                                Text(
                                  '${direccion.calle} ${direccion.numero}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(
                                  height: AppSizes.spacingXs,
                                ),
                                Text(
                                  direccion.colonia,
                                  style: const TextStyle(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(
                                  height: AppSizes.spacingXs,
                                ),
                                Text(
                                  'CP ${direccion.codigoPostal}',
                                  style: const TextStyle(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuButton<String>(
                            tooltip: 'Opciones',
                            onSelected: (value) async {
                              switch (value) {
                                case 'editar':
                                  await _editarDireccion(
                                    context,
                                    direccion,
                                  );
                                  break;

                                case 'principal':
                                  direccionProvider
                                      .establecerDireccionPrincipal(
                                    direccion,
                                  );

                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Dirección principal actualizada',
                                          ),
                                        ),
                                      );
                                  }
                                  break;

                                case 'eliminar':
                                  await _eliminarDireccion(
                                    context,
                                    direccionProvider,
                                    direccion,
                                  );
                                  break;
                              }
                            },
                            itemBuilder: (context) {
                              return [
                                const PopupMenuItem<String>(
                                  value: 'editar',
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.edit_outlined,
                                        size: 20,
                                        color: AppColors.textSecondary,
                                      ),
                                      SizedBox(
                                        width: AppSizes.spacingSm,
                                      ),
                                      Text('Editar'),
                                    ],
                                  ),
                                ),
                                if (!direccion.principal)
                                  const PopupMenuItem<String>(
                                    value: 'principal',
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.star_outline_rounded,
                                          size: 20,
                                          color: AppColors.primary,
                                        ),
                                        SizedBox(
                                          width: AppSizes.spacingSm,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Establecer como principal',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                const PopupMenuDivider(),
                                const PopupMenuItem<String>(
                                  value: 'eliminar',
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.delete_outline_rounded,
                                        size: 20,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width: AppSizes.spacingSm,
                                      ),
                                      Text(
                                        'Eliminar',
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ];
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: direcciones.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: () async {
                await _agregarDireccion(context);
              },
              icon: const Icon(
                Icons.add_location_alt_outlined,
              ),
              label: const Text(
                'Nueva dirección',
              ),
            ),
    );
  }

  static Future<void> _agregarDireccion(
    BuildContext context,
  ) async {
    final resultado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => const AgregarDireccionScreen(),
      ),
    );

    if (resultado == true && context.mounted) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text(
              'Dirección agregada correctamente',
            ),
          ),
        );
    }
  }

  static Future<void> _editarDireccion(
    BuildContext context,
    Direccion direccion,
  ) async {
    final resultado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => AgregarDireccionScreen(
          direccion: direccion,
        ),
      ),
    );

    if (resultado == true && context.mounted) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text(
              'Dirección actualizada correctamente',
            ),
          ),
        );
    }
  }

  static Future<void> _eliminarDireccion(
    BuildContext context,
    DireccionProvider direccionProvider,
    Direccion direccion,
  ) async {
    final confirmar = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => EliminarDireccionDialog(
        alias: direccion.alias,
      ),
    );

    if (confirmar != true || !context.mounted) {
      return;
    }

    direccionProvider.eliminarDireccion(
      direccion.id,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text(
            'Dirección eliminada correctamente',
          ),
        ),
      );
  }
}
