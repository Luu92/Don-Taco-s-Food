import 'package:demo_app/core/core.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usuario = context.watch<PerfilProvider>().perfil;
    final textTheme = Theme.of(context).textTheme;

    if (usuario == null) {
      return const Scaffold(
        body: SafeArea(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi cuenta'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(
            AppSizes.spacingMd,
          ),
          children: [
            // Encabezado del perfil
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(
                AppSizes.spacingLg,
              ),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(
                  AppSizes.radiusLarge,
                ),
                border: Border.all(
                  color: AppColors.border,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(0.14),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.secondary.withOpacity(0.55),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      size: 52,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(
                    height: AppSizes.spacingMd,
                  ),
                  Text(
                    usuario.nombre,
                    textAlign: TextAlign.center,
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(
                    height: AppSizes.spacingXs,
                  ),
                  Text(
                    usuario.correo,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(
                    height: AppSizes.spacingSm,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.spacingMd,
                      vertical: AppSizes.spacingSm,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(
                        AppSizes.radiusLarge,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.phone_outlined,
                          size: 18,
                          color: AppColors.primary,
                        ),
                        const SizedBox(
                          width: AppSizes.spacingSm,
                        ),
                        Text(
                          usuario.telefono,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
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
              'Mi información',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(
              height: AppSizes.spacingMd,
            ),

            // Opciones del perfil
            Card(
              margin: EdgeInsets.zero,
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  _OpcionPerfilTile(
                    icono: Icons.receipt_long_outlined,
                    titulo: 'Mis pedidos',
                    subtitulo: 'Consulta el estado y detalle de tus órdenes',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PedidosScreen(),
                        ),
                      );
                    },
                  ),
                  const Divider(
                    height: 1,
                    indent: 72,
                  ),
                  _OpcionPerfilTile(
                    icono: Icons.location_on_outlined,
                    titulo: 'Mis direcciones',
                    subtitulo: 'Administra tus lugares de entrega',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DireccionesScreen(),
                        ),
                      );
                    },
                  ),
                  const Divider(
                    height: 1,
                    indent: 72,
                  ),
                  _OpcionPerfilTile(
                    icono: Icons.edit_outlined,
                    titulo: 'Editar perfil',
                    subtitulo: 'Actualiza tu nombre y teléfono',
                    onTap: () async {
                      final resultado = await Navigator.push<bool>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const EditarPerfilScreen(),
                        ),
                      );

                      if (resultado == true && context.mounted) {
                        await showDialog<void>(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) {
                            return const PerfilActualizadoDialog();
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: AppSizes.spacingLg,
            ),

            // Cerrar sesión
            SizedBox(
              width: double.infinity,
              height: AppSizes.buttonHeight,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(
                    color: AppColors.primary,
                  ),
                ),
                onPressed: () async {
                  await _cerrarSesion(context);
                },
                icon: const Icon(
                  Icons.logout_rounded,
                ),
                label: const Text(
                  'Cerrar sesión',
                ),
              ),
            ),

            const SizedBox(
              height: AppSizes.spacingLg,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _cerrarSesion(
    BuildContext context,
  ) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (_) => const CerrarSesionDialog(),
    );

    if (confirmar != true || !context.mounted) {
      return;
    }

    context.read<CarritoProvider>().limpiarCarrito();
    context.read<PedidoProvider>().limpiar();
    context.read<DireccionProvider>().limpiar();
    context.read<PerfilProvider>().limpiar();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const Login(),
      ),
      (route) => false,
    );
  }
}

class _OpcionPerfilTile extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final String subtitulo;
  final VoidCallback onTap;

  const _OpcionPerfilTile({
    required this.icono,
    required this.titulo,
    required this.subtitulo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSizes.spacingMd,
        vertical: AppSizes.spacingSm,
      ),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.secondary.withOpacity(0.12),
          borderRadius: BorderRadius.circular(
            AppSizes.radiusMedium,
          ),
        ),
        child: Icon(
          icono,
          color: AppColors.primary,
        ),
      ),
      title: Text(
        titulo,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
      subtitle: Text(
        subtitulo,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: AppColors.textSecondary,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: AppColors.textSecondary,
      ),
      onTap: onTap,
    );
  }
}
