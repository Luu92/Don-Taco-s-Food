import 'package:demo_app/features/carrito/providers/carrito_provider.dart';
import 'package:demo_app/features/pedidos/providers/pedido_provider.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito'),
      ),
      body: carrito.items.isEmpty
          ? const Center(
              child: Text('Carrito vacío'),
            )
          : Column(
              children: [
                //Lista de alimentos
                Expanded(
                  child: ListView.builder(
                    itemCount: carrito.items.length,
                    itemBuilder: (context, index) {
                      final item = carrito.items.values.toList()[index];
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
                              // Nombre y boton eliminar
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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

                              // Controles cantidad
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
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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

                              // Subtotal
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
                    },
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
                  onPressed: () {
                    print(
                      comentariosController.text,
                    );

                    final pedido = Pedido(
                        id: DateTime.now().millisecondsSinceEpoch,
                        fecha: DateTime.now(),
                        estado: "Pendiente",
                        total: carrito.total,
                        comentario: comentariosController.text,
                        alimentos: carrito.items.values.toList());

                    context.read<PedidoProvider>().agregarPedido(pedido);

                    carrito.limpiarCarrito();

                    comentariosController.clear();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Pedido enviado',
                        ),
                      ),
                    );
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
