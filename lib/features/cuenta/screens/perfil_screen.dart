import 'package:demo_app/features/cuenta/providers/perfil_provider.dart';
import 'package:demo_app/features/cuenta/screens/editar_perfil_screen.dart';
import 'package:demo_app/features/cuenta/widgets/perfil_actualizado_dialog.dart';
import 'package:demo_app/features/direcciones/screens/direcciones_screen.dart';
import 'package:demo_app/features/pedidos/screens/pedidos_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usuario = context.watch<PerfilProvider>().perfil;

    if (usuario == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Cuenta'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const CircleAvatar(
            radius: 45,
            child: Icon(
              Icons.person,
              size: 45,
            ),
          ),
          const SizedBox(height: 15),
          Center(
            child: Text(
              usuario.nombre,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Text(
              usuario.correo,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Center(
            child: Text(
              usuario.telefono,
            ),
          ),
          const SizedBox(height: 30),
          Card(
            child: ListTile(
              leading: const Icon(Icons.receipt_long),
              title: const Text('Mis pedidos'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PedidosScreen(),
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('Mis direcciones'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DireccionesScreen(),
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Editar perfil'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                final resultado = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EditarPerfilScreen(),
                  ),
                );

                if (resultado == true && context.mounted) {
                  await showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) {
                      return const PerfilActualizadoDialog();
                    },
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.logout),
            label: const Text('Cerrar sesión'),
          ),
        ],
      ),
    );
  }
}
