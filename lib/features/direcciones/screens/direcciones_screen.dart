import 'package:demo_app/features/direcciones/providers/direccion_provider.dart';
import 'package:demo_app/features/direcciones/screens/agregar_direccion_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DireccionesScreen extends StatelessWidget {
  const DireccionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final direccionProvider = context.read<DireccionProvider>();
    final direcciones = context.watch<DireccionProvider>().direcciones;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis direcciones"),
      ),
      body: direcciones.isEmpty
          ? const Center(
              child: Text(
                "No tienes direcciones registradas\nAgrega una para poder recibir tus pedidos.",
              ),
            )
          : ListView.builder(
              itemCount: direcciones.length,
              itemBuilder: (context, index) {
                final direccion = direcciones[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: const Icon(
                      Icons.location_on,
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            direccion.alias,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (direccion.principal)
                          const Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 18,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "Principal",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${direccion.calle} ${direccion.numero}",
                        ),
                        Text(
                          direccion.colonia,
                        ),
                        Text("CP ${direccion.codigoPostal}"),
                      ],
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) async {
                        switch (value) {
                          case "editar":
                            final resultado = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AgregarDireccionScreen(
                                  direccion: direccion,
                                ),
                              ),
                            );

                            if (resultado == true && context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Dirección actualizada correctamente',
                                  ),
                                ),
                              );
                            }
                            break;
                          case "principal":
                            direccionProvider
                                .establecerDireccionPrincipal(direccion);
                            break;
                          case "eliminar":
                            direccionProvider.eliminarDireccion(direccion.id);
                            break;
                        }
                      },
                      itemBuilder: (context) {
                        return [
                          const PopupMenuItem(
                            value: "editar",
                            child: Row(
                              children: [
                                Icon(Icons.edit,
                                    color: Colors.blueGrey, size: 20),
                                SizedBox(width: 10),
                                Text("Editar"),
                              ],
                            ),
                          ),
                          if (!direccion.principal)
                            const PopupMenuItem(
                              value: "principal",
                              child: Row(
                                children: [
                                  Icon(Icons.star,
                                      color: Colors.amber, size: 20),
                                  SizedBox(width: 10),
                                  Text("Establecer como principal"),
                                ],
                              ),
                            ),
                          const PopupMenuItem(
                            value: "eliminar",
                            child: Row(
                              children: [
                                Icon(Icons.delete, color: Colors.red, size: 20),
                                SizedBox(width: 10),
                                Text("Eliminar"),
                              ],
                            ),
                          ),
                        ];
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final resultado = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AgregarDireccionScreen(),
            ),
          );

          if (resultado == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Dirección agregada correctamente"),
              ),
            );
          }
        },
        icon: const Icon(Icons.add_location_alt),
        label: const Text("Nueva dirección"),
      ),
    );
  }
}
