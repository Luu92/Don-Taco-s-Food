import 'package:demo_app/features/carrito/providers/carrito_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PedidosScreen extends StatelessWidget {
  const PedidosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final carrito = context.watch<CarritoProvider>().items;

    return Scaffold(
      appBar: AppBar(title: const Text('Tu Pedido')),
      body: carrito.isEmpty
          ? const Center(child: Text('No has agregado alimentos'))
          : ListView(
              children: carrito.entries.map((entry) {
                final alimento = entry.value;
                return ListTile(
                  title: Text(alimento['nombre']),
                  subtitle: Text('Cantidad: ${alimento['cantidad']}'),
                  trailing:
                      Text("\$${alimento['precio'] * alimento['cantidad']}"),
                );
              }).toList(),
            ),
    );
  }
}
