import 'package:demo_app/features/direcciones/providers/direccion_provider.dart';
import 'package:demo_app/features/direcciones/screens/agregar_direccion_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DireccionesScreen extends StatelessWidget {
  const DireccionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final direccionProvider = context.watch<DireccionProvider>();
    final direcciones = direccionProvider.direcciones;
    print("Cantidad de direcciones: ${direcciones.length}");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis direcciones"),
      ),
      body: direcciones.isEmpty
          ? const Center(
              child: Text(
                "No tienes direcciones registradas",
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
                    title: Text(
                      direccion.alias,
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
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
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
                content: Text(
                  "Dirección agregada correctamente",
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
