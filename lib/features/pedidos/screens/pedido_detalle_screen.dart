import 'package:demo_app/features/pedidos/widgets/estado_pedido_widget.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/models/pedido.dart';

class PedidoDetalleScreen extends StatelessWidget {
  final Pedido pedido;

  const PedidoDetalleScreen({
    super.key,
    required this.pedido,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedido #${pedido.id}"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pedido #${pedido.id}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  EstadoPedidoWidget(
                    estado: pedido.estado,
                  ),
                  const SizedBox(height: 10),
                  Text("Fecha: ${pedido.fecha}"),
                  const SizedBox(height: 20),
                  //Lista de Alimentos
                  const Text(
                    "Alimentos",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...pedido.alimentos.map((alimento) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          alimento['nombre'],
                        ),
                        subtitle: Text(
                          "Cantidad: ${alimento['cantidad']}",
                        ),
                        trailing: Text(
                          "\$${alimento['precio'] * alimento['cantidad']}",
                        ),
                      ),
                    );
                  }),
                  //Comentarios
                  const SizedBox(height: 20),
                  const Text(
                    "Comentarios",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),
                  Text(
                    pedido.comentario.isEmpty
                        ? "Sin comentarios"
                        : pedido.comentario,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
