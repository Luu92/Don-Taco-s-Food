import 'package:demo_app/core/core.dart';

class PedidosScreen extends StatelessWidget {
  const PedidosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pedidoProvider = context.watch<PedidoProvider>();
    final pedidos = pedidoProvider.pedidos;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis pedidos'),
      ),
      body: SafeArea(
        child: pedidos.isEmpty
            ? const PedidosVacios()
            : ListView.separated(
                padding: const EdgeInsets.all(
                  AppSizes.spacingMd,
                ),
                itemCount: pedidos.length,
                separatorBuilder: (_, __) => const SizedBox(
                  height: AppSizes.spacingMd,
                ),
                itemBuilder: (context, index) {
                  final pedido = pedidos[index];

                  return Card(
                    margin: EdgeInsets.zero,
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PedidoDetalleScreen(
                              pedido: pedido,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(
                          AppSizes.spacingMd,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color:
                                        AppColors.secondary.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(
                                      AppSizes.radiusMedium,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.receipt_long_outlined,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(
                                  width: AppSizes.spacingMd,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Pedido #${pedido.id}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: AppSizes.spacingXs,
                                      ),
                                      Text(
                                        _formatearFecha(
                                          pedido.fecha,
                                        ),
                                        style: textTheme.bodySmall?.copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.chevron_right_rounded,
                                  color: AppColors.textSecondary,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: AppSizes.spacingMd,
                            ),
                            EstadoPedidoWidget(
                              estado: pedido.estado,
                            ),
                            const SizedBox(
                              height: AppSizes.spacingMd,
                            ),
                            const Divider(height: 1),
                            const SizedBox(
                              height: AppSizes.spacingMd,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Comentarios',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: AppSizes.spacingXs,
                                      ),
                                      Text(
                                        pedido.comentario.isEmpty
                                            ? 'Sin comentarios'
                                            : pedido.comentario,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: AppSizes.spacingMd,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text(
                                      'Total',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    Text(
                                      '\$${pedido.total.toStringAsFixed(0)}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
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
    );
  }

  static String _formatearFecha(DateTime fecha) {
    final dia = fecha.day.toString().padLeft(2, '0');
    final mes = fecha.month.toString().padLeft(2, '0');
    final anio = fecha.year;

    final hora = fecha.hour.toString().padLeft(2, '0');
    final minuto = fecha.minute.toString().padLeft(2, '0');

    return '$dia/$mes/$anio · $hora:$minuto';
  }
}
