import 'package:demo_app/features/carrito/providers/carrito_provider.dart';
import 'package:demo_app/features/direcciones/providers/direccion_provider.dart';
import 'package:demo_app/features/direcciones/screens/agregar_direccion_screen.dart';
import 'package:demo_app/features/direcciones/screens/direcciones_screen.dart';
import 'package:demo_app/features/menu/screens/categorias_screen.dart';
import 'package:demo_app/features/pedidos/providers/pedido_provider.dart';
import 'package:demo_app/features/pedidos/screens/pedidos_screen.dart';
import 'package:demo_app/features/pedidos/widgets/confirmar_pedido_dialog.dart';
import 'package:demo_app/features/pedidos/widgets/pedido_enviado_dialog.dart';
import 'package:demo_app/models/pedido.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class CarritoScreen extends StatefulWidget {
  const CarritoScreen({super.key});

  @override
  State<CarritoScreen> createState() => _CarritoScreenState();
}

class _CarritoScreenState extends State<CarritoScreen> {
  final TextEditingController comentariosController = TextEditingController();

  @override
  void dispose() {
    comentariosController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final carrito = Provider.of<CarritoProvider>(context);
    final direccionProvider = context.watch<DireccionProvider>();
    final direccionPrincipal = direccionProvider.obtenerDireccionPrincipal();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito'),
      ),
      body: carrito.items.isEmpty
          ? const Center(
              child: Text('Carrito vacío'),
            )
          : ListView(
              padding: const EdgeInsets.only(bottom: 24),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                ...carrito.items.values.map((item) {
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  item['nombre'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  carrito.eliminarProducto(
                                    item['nombre'],
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  carrito.disminuirCantidad(
                                    item['nombre'],
                                  );
                                },
                              ),
                              Text(
                                '${item['cantidad']}',
                                style: const TextStyle(fontSize: 18),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  carrito.incrementarCantidad(
                                    item['nombre'],
                                  );
                                },
                              ),
                            ],
                          ),
                          if (item['nombre'] == 'Taco al Pastor') ...[
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '🎉 Promoción 2x1 aplicada',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Recibirás: ${item['cantidad'] * 2} tacos',
                                  ),
                                ],
                              ),
                            ),
                          ],
                          const SizedBox(height: 10),
                          Text(
                            'Subtotal: \$${item['precio'] * item['cantidad']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),

                //Direccion
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: direccionPrincipal == null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Icon(Icons.location_off),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'No tienes una dirección de entrega registrada',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                OutlinedButton.icon(
                                  icon: const Icon(Icons.add_location_alt),
                                  label: const Text('Agregar dirección'),
                                  onPressed: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            const AgregarDireccionScreen(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Dirección de entrega',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      direccionPrincipal.alias,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${direccionPrincipal.calle} '
                                  '${direccionPrincipal.numero}',
                                ),
                                Text(direccionPrincipal.colonia),
                                Text(
                                  'CP ${direccionPrincipal.codigoPostal}',
                                ),
                                const SizedBox(height: 10),
                                OutlinedButton.icon(
                                  icon: const Icon(Icons.swap_horiz),
                                  label: const Text('Cambiar dirección'),
                                  onPressed: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            const DireccionesScreen(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                    ),
                  ),
                ),

                //Total
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Total: \$${carrito.total}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                //Caja de comentarios
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: TextField(
                    controller: comentariosController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Comentarios para la taquería',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                //Vaciar carrito
                ElevatedButton.icon(
                  icon: const Icon(Icons.delete),
                  label: const Text('Vaciar carrito'),
                  onPressed: () {
                    carrito.limpiarCarrito();
                  },
                ),
                //Confirmar pedido
                ElevatedButton(
                  onPressed: () async {
                    if (direccionPrincipal == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Debes registrar una dirección antes de confirmar tu pedido.",
                          ),
                        ),
                      );
                      return;
                    }

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
                        estado: "Recibido",
                        total: carrito.total,
                        comentario: comentariosController.text.trim(),
                        alimentos: carrito.items.values
                            .map((item) => Map<String, dynamic>.from(item))
                            .toList(),
                        direccionEntrega: direccionPrincipal);

                    context.read<PedidoProvider>().agregarPedido(pedido);

                    carrito.limpiarCarrito();

                    comentariosController.clear();

                    final accion = await showDialog<AccionPedidoEnviado>(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) {
                        return PedidoEnviadoDialog(
                          numeroPedido: pedido.id,
                        );
                      },
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
                  },
                  child: const Text(
                    'Confirmar pedido',
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
    );
  }
}
