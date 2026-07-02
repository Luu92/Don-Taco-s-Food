import 'package:demo_app/features/pedidos/screens/pedido_detalle_screen.dart';
import 'package:demo_app/features/pedidos/widgets/estado_pedido_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_app/features/pedidos/providers/pedido_provider.dart';

class PedidosScreen extends StatelessWidget {
  const PedidosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pedidoProvider = context.watch<PedidoProvider>();
    final pedidos = pedidoProvider.pedidos;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis pedidos"),
      ),
      body: pedidos.isEmpty
          ? const Center(
              child: Text("Aún no has realizado pedidos"),
            )
          : ListView.builder(
              itemCount: pedidos.length,
              itemBuilder: (context, index) {
                final pedido = pedidos[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
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
                    title: Text("Pedido #${pedido.id}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EstadoPedidoWidget(estado: pedido.estado),
                        Text("Fecha: ${pedido.fecha}"),
                        const SizedBox(height: 6),
                        const Text(
                          "Comentarios:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          pedido.comentario.isEmpty
                              ? "Sin comentarios"
                              : pedido.comentario,
                        ),
                      ],
                    ),
                    trailing: Text(
                      "\$${pedido.total}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
