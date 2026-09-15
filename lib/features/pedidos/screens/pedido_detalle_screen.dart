import 'package:demo_app/core/core.dart';

class PedidoDetalleScreen extends StatelessWidget {
  final Pedido pedido;

  const PedidoDetalleScreen({
    super.key,
    required this.pedido,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final pedidoActual = context.watch<PedidoProvider>().pedidos.firstWhere(
          (p) => p.id == pedido.id,
          orElse: () => pedido,
        );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pedido #${pedidoActual.id}',
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(
            AppSizes.spacingMd,
          ),
          children: [
            // Información general del pedido
            Card(
              margin: EdgeInsets.zero,
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
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: AppColors.secondary.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(
                              AppSizes.radiusMedium,
                            ),
                          ),
                          child: const Icon(
                            Icons.receipt_long_outlined,
                            color: AppColors.primary,
                            size: 28,
                          ),
                        ),
                        const SizedBox(
                          width: AppSizes.spacingMd,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pedido #${pedidoActual.id}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(
                                height: AppSizes.spacingXs,
                              ),
                              Text(
                                _formatearFecha(pedidoActual.fecha),
                                style: textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: AppSizes.spacingMd,
                    ),
                    EstadoPedidoWidget(
                      estado: pedidoActual.estado,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: AppSizes.spacingLg,
            ),

            // Dirección de entrega
            Text(
              'Dirección de entrega',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(
              height: AppSizes.spacingMd,
            ),

            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(
                  AppSizes.spacingMd,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(
                          AppSizes.radiusMedium,
                        ),
                      ),
                      child: const Icon(
                        Icons.location_on_outlined,
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
                              const Icon(
                                Icons.star_rounded,
                                size: 18,
                                color: AppColors.secondary,
                              ),
                              const SizedBox(
                                width: AppSizes.spacingXs,
                              ),
                              Expanded(
                                child: Text(
                                  pedidoActual.direccionEntrega.alias,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: AppSizes.spacingSm,
                          ),
                          Text(
                            '${pedidoActual.direccionEntrega.calle} '
                            '${pedidoActual.direccionEntrega.numero}',
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(
                            height: AppSizes.spacingXs,
                          ),
                          Text(
                            pedidoActual.direccionEntrega.colonia,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(
                            height: AppSizes.spacingXs,
                          ),
                          Text(
                            'CP ${pedidoActual.direccionEntrega.codigoPostal}',
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: AppSizes.spacingLg,
            ),

            // Alimentos
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Alimentos',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  '${pedidoActual.alimentos.length} productos',
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: AppSizes.spacingMd,
            ),

            ...pedidoActual.alimentos.map(
              (alimento) {
                final nombre = alimento['nombre'] as String;
                final cantidad = alimento['cantidad'] as int;
                final precio = alimento['precio'] as num;
                final subtotal = precio * cantidad;

                final tienePromocion = nombre == 'Taco al Pastor';

                return Card(
                  margin: const EdgeInsets.only(
                    bottom: AppSizes.spacingMd,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(
                      AppSizes.spacingMd,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 46,
                              height: 46,
                              decoration: BoxDecoration(
                                color: AppColors.secondary.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(
                                  AppSizes.radiusMedium,
                                ),
                              ),
                              child: const Icon(
                                Icons.restaurant_rounded,
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
                                  Text(
                                    nombre,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: AppSizes.spacingXs,
                                  ),
                                  Text(
                                    'Cantidad: $cantidad',
                                    style: const TextStyle(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '\$${subtotal.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        if (tienePromocion) ...[
                          const SizedBox(
                            height: AppSizes.spacingMd,
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(
                              AppSizes.spacingSm,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.secondary.withOpacity(0.14),
                              borderRadius: BorderRadius.circular(
                                AppSizes.radiusMedium,
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.local_offer_outlined,
                                  size: 20,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(
                                  width: AppSizes.spacingSm,
                                ),
                                Expanded(
                                  child: Text(
                                    'Promoción 2×1 aplicada. '
                                    'Se prepararon ${cantidad * 2} tacos.',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(
              height: AppSizes.spacingSm,
            ),

            // Comentarios
            Text(
              'Comentarios',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(
              height: AppSizes.spacingMd,
            ),

            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(
                  AppSizes.spacingMd,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(
                          AppSizes.radiusMedium,
                        ),
                      ),
                      child: const Icon(
                        Icons.comment_outlined,
                        size: 22,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(
                      width: AppSizes.spacingMd,
                    ),
                    Expanded(
                      child: Text(
                        pedidoActual.comentario.trim().isEmpty
                            ? 'Sin comentarios'
                            : pedidoActual.comentario,
                        style: TextStyle(
                          height: 1.5,
                          color: pedidoActual.comentario.trim().isEmpty
                              ? AppColors.textSecondary
                              : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: AppSizes.spacingLg,
            ),

            // Total
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(
                  AppSizes.spacingMd,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total del pedido',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(
                          height: AppSizes.spacingXs,
                        ),
                        Text(
                          'Importe pagado',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '\$${pedidoActual.total.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: AppSizes.spacingXs,
            ),

            //Slader para confirma pedido
            if (pedidoActual.estado == 'En camino') ...[
              const SizedBox(
                height: AppSizes.spacingLg,
              ),
              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(
                    AppSizes.spacingMd,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Confirma la entrega',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(
                        height: AppSizes.spacingSm,
                      ),
                      const Text(
                        'Cuando recibas tu pedido, desliza '
                        'para confirmar la entrega.',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(
                        height: AppSizes.spacingMd,
                      ),
                      ConfirmarEntregaSlider(
                        onConfirmar: () async {
                          final confirmar = await showDialog<bool>(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => const ConfirmarEntregaDialog(),
                          );

                          if (confirmar != true || !context.mounted) {
                            return;
                          }

                          context
                              .read<PedidoProvider>()
                              .confirmarEntrega(pedidoActual.id);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
            if (pedidoActual.estado == 'Entregado') ...[
              const SizedBox(
                height: AppSizes.spacingLg,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(
                  AppSizes.spacingMd,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(
                    AppSizes.radiusMedium,
                  ),
                  border: Border.all(
                    color: Colors.green.withOpacity(0.30),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: AppSizes.spacingSm,
                    ),
                    Expanded(
                      child: Text(
                        'Pedido entregado. Gracias por '
                        'confirmar que lo recibiste.',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(
              height: AppSizes.spacingXl,
            ),
          ],
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

    return '$dia/$mes/$anio · $hora:$minuto hrs';
  }
}
