import 'package:demo_app/core/core.dart';

class CarritoScreen extends StatefulWidget {
  const CarritoScreen({super.key});

  @override
  State<CarritoScreen> createState() => _CarritoScreenState();
}

class _CarritoScreenState extends State<CarritoScreen> {
  final TextEditingController comentariosController = TextEditingController();

  static const double montoMinimoDomicilio = 200;

  @override
  void dispose() {
    comentariosController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final carrito = context.watch<CarritoProvider>();
    final direccionProvider = context.watch<DireccionProvider>();

    final direccionPrincipal = direccionProvider.obtenerDireccionPrincipal();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito'),
      ),

      // Estado vacío o contenido del carrito
      body: carrito.items.isEmpty
          ? const CarritoVacio()
          : ListView(
              padding: const EdgeInsets.only(
                bottom: AppSizes.spacingLg,
              ),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                const SizedBox(
                  height: AppSizes.spacingSm,
                ),

                // Productos agregados
                ...carrito.items.values.map(
                  (item) {
                    return _ProductoCarritoCard(
                      item: item,
                      onDisminuir: () {
                        carrito.disminuirCantidad(
                          item['nombre'],
                        );
                      },
                      onIncrementar: () {
                        carrito.incrementarCantidad(
                          item['nombre'],
                        );
                      },
                      onEliminar: () {
                        carrito.eliminarProducto(
                          item['nombre'],
                        );
                      },
                    );
                  },
                ),

                // Dirección de entrega
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.spacingMd,
                    vertical: AppSizes.spacingSm,
                  ),
                  child: _DireccionEntregaCard(
                    direccionPrincipal: direccionPrincipal,
                  ),
                ),

                // Resumen del pedido
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.spacingMd,
                    vertical: AppSizes.spacingSm,
                  ),
                  child: _ResumenPedidoCard(
                    total: carrito.total,
                  ),
                ),

                // Comentarios
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.spacingMd,
                    vertical: AppSizes.spacingSm,
                  ),
                  child: TextField(
                    controller: comentariosController,
                    maxLines: 3,
                    maxLength: 200,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      labelText: 'Comentarios para la taquería',
                      hintText: 'Ej. Sin cebolla, salsa aparte...',
                      prefixIcon: Icon(
                        Icons.comment_outlined,
                      ),
                      alignLabelWithHint: true,
                    ),
                  ),
                ),

                // Botones
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSizes.spacingMd,
                    AppSizes.spacingSm,
                    AppSizes.spacingMd,
                    0,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: AppSizes.buttonHeight,
                        child: OutlinedButton.icon(
                          icon: const Icon(
                            Icons.delete_outline_rounded,
                          ),
                          label: const Text(
                            'Vaciar carrito',
                          ),
                          onPressed: () {
                            carrito.limpiarCarrito();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: AppSizes.spacingMd,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: AppSizes.buttonHeight,
                        child: ElevatedButton.icon(
                          icon: const Icon(
                            Icons.check_circle_outline,
                          ),
                          label: const Text(
                            'Confirmar pedido',
                          ),
                          onPressed: () async {
                            await _confirmarPedido(
                              context: context,
                              carrito: carrito,
                              direccionPrincipal: direccionPrincipal,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: AppSizes.spacingLg,
                ),
              ],
            ),
    );
  }

  Future<void> _confirmarPedido({
    required BuildContext context,
    required CarritoProvider carrito,
    required Direccion? direccionPrincipal,
  }) async {
    // Validación del monto mínimo
    if (carrito.total < montoMinimoDomicilio) {
      await showDialog<void>(
        context: context,
        builder: (_) => const MontoMinimoDialog(
          montoMinimo: montoMinimoDomicilio,
        ),
      );

      return;
    }

    if (!context.mounted) {
      return;
    }

    // Validación de dirección
    if (direccionPrincipal == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text(
              'Debes registrar una dirección antes '
              'de confirmar tu pedido.',
            ),
          ),
        );

      return;
    }

    // Confirmación del pedido
    final confirmar = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => ConfirmarPedidoDialog(
        items: carrito.items,
        direccion: direccionPrincipal,
        total: carrito.total,
        comentario: comentariosController.text,
      ),
    );

    if (confirmar != true || !context.mounted) {
      return;
    }

    final pedido = Pedido(
      id: DateTime.now().millisecondsSinceEpoch,
      fecha: DateTime.now(),
      estado: 'Recibido',
      total: carrito.total,
      comentario: comentariosController.text.trim(),
      alimentos: carrito.items.values
          .map(
            (item) => Map<String, dynamic>.from(item),
          )
          .toList(),
      direccionEntrega: direccionPrincipal,
    );

    context.read<PedidoProvider>().agregarPedido(pedido);

    carrito.limpiarCarrito();
    comentariosController.clear();

    final accion = await showDialog<AccionPedidoEnviado>(
      context: context,
      barrierDismissible: false,
      builder: (_) => PedidoEnviadoDialog(
        numeroPedido: pedido.id,
      ),
    );

    if (!context.mounted) {
      return;
    }

    if (accion == AccionPedidoEnviado.verPedidos) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const PedidosScreen(),
        ),
      );
    } else if (accion == AccionPedidoEnviado.seguirComprando) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const CategoriasScreen(),
        ),
        (route) => false,
      );
    }
  }
}

class _ProductoCarritoCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onDisminuir;
  final VoidCallback onIncrementar;
  final VoidCallback onEliminar;

  const _ProductoCarritoCard({
    required this.item,
    required this.onDisminuir,
    required this.onIncrementar,
    required this.onEliminar,
  });

  @override
  Widget build(BuildContext context) {
    final nombre = item['nombre'] as String;
    final cantidad = item['cantidad'] as int;
    final precio = item['precio'] as num;

    final subtotal = precio * cantidad;
    final tienePromocion = nombre == 'Taco al Pastor';

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSizes.spacingMd,
        vertical: AppSizes.spacingSm,
      ),
      clipBehavior: Clip.antiAlias,
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
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(
                        height: AppSizes.spacingXs,
                      ),
                      Text(
                        '\$${precio.toStringAsFixed(0)} c/u',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: 'Eliminar producto',
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                  ),
                  color: AppColors.primary,
                  onPressed: onEliminar,
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
                  border: Border.all(
                    color: AppColors.secondary.withOpacity(0.50),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.local_offer_outlined,
                      color: AppColors.primary,
                    ),
                    const SizedBox(
                      width: AppSizes.spacingSm,
                    ),
                    Expanded(
                      child: Text(
                        'Promoción 2×1 aplicada. '
                        'Recibirás ${cantidad * 2} tacos.',
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
            const SizedBox(
              height: AppSizes.spacingMd,
            ),
            Row(
              children: [
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(
                      AppSizes.radiusMedium,
                    ),
                    border: Border.all(
                      color: AppColors.border,
                    ),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        tooltip: 'Disminuir',
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          minHeight: 40,
                        ),
                        icon: const Icon(
                          Icons.remove,
                          size: 19,
                        ),
                        onPressed: onDisminuir,
                      ),
                      SizedBox(
                        width: 32,
                        child: Text(
                          '$cantidad',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: 'Aumentar',
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          minHeight: 40,
                        ),
                        icon: const Icon(
                          Icons.add,
                          size: 19,
                        ),
                        onPressed: onIncrementar,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Subtotal',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      '\$${subtotal.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 19,
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
    );
  }
}

/// Tarjeta con la dirección seleccionada.
class _DireccionEntregaCard extends StatelessWidget {
  final Direccion? direccionPrincipal;

  const _DireccionEntregaCard({
    required this.direccionPrincipal,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(
          AppSizes.spacingMd,
        ),
        child: direccionPrincipal == null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.location_off_outlined,
                        color: AppColors.primary,
                      ),
                      SizedBox(
                        width: AppSizes.spacingSm,
                      ),
                      Expanded(
                        child: Text(
                          'No tienes una dirección '
                          'de entrega registrada',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppSizes.spacingMd,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      icon: const Icon(
                        Icons.add_location_alt_outlined,
                      ),
                      label: const Text(
                        'Agregar dirección',
                      ),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AgregarDireccionScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: AppColors.primary,
                      ),
                      SizedBox(
                        width: AppSizes.spacingSm,
                      ),
                      Text(
                        'Dirección de entrega',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppSizes.spacingMd,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: AppColors.secondary,
                        size: 20,
                      ),
                      const SizedBox(
                        width: AppSizes.spacingXs,
                      ),
                      Text(
                        direccionPrincipal!.alias,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppSizes.spacingXs,
                  ),
                  Text(
                    '${direccionPrincipal!.calle} '
                    '${direccionPrincipal!.numero}',
                  ),
                  Text(
                    direccionPrincipal!.colonia,
                  ),
                  Text(
                    'CP ${direccionPrincipal!.codigoPostal}',
                  ),
                  const SizedBox(
                    height: AppSizes.spacingMd,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      icon: const Icon(
                        Icons.swap_horiz_rounded,
                      ),
                      label: const Text(
                        'Cambiar dirección',
                      ),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const DireccionesScreen(),
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

/// Tarjeta con el total actual.
class _ResumenPedidoCard extends StatelessWidget {
  final num total;

  const _ResumenPedidoCard({
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(
          AppSizes.spacingMd,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resumen del pedido',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(
              height: AppSizes.spacingMd,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  '\$${total.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: AppSizes.spacingSm,
            ),
            Text(
              'Compra mínima a domicilio: '
              '\$${_CarritoScreenState.montoMinimoDomicilio.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
