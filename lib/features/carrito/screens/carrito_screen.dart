import 'package:demo_app/features/carrito/providers/carrito_provider.dart';
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

                      return ListTile(
                        title: Text(item['nombre']),
                        subtitle: Text(
                          'Cantidad: ${item['cantidad']}',
                        ),
                        trailing: Text(
                          '\$${item['precio'] * item['cantidad']}',
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

/*
class CarritoScreen extends StatelessWidget {
  const CarritoScreen({super.key});

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
          : ListView.builder(
              itemCount: carrito.items.length,
              itemBuilder: (context, index) {
                final item = carrito.items.values.toList()[index];

                return ListTile(
                  title: Text(item['nombre']),
                  subtitle: Text(
                    'Cantidad: ${item['cantidad']}',
                  ),
                  trailing: Text(
                    '\$${item['precio'] * item['cantidad']}',
                  ),
                );
              },
            ),
    );
  }
}
*/
