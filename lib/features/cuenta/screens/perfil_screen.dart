import 'package:demo_app/features/auth/screens/login.dart';
import 'package:demo_app/features/carrito/providers/carrito_provider.dart';
import 'package:demo_app/features/cuenta/providers/perfil_provider.dart';
import 'package:demo_app/features/cuenta/screens/editar_perfil_screen.dart';
import 'package:demo_app/features/cuenta/widgets/perfil_actualizado_dialog.dart';
import 'package:demo_app/features/direcciones/providers/direccion_provider.dart';
import 'package:demo_app/features/direcciones/screens/direcciones_screen.dart';
import 'package:demo_app/features/pedidos/providers/pedido_provider.dart';
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
            onPressed: () async {
              final confirmar = await mostrarConfirmacionCerrarSesion(context);

              if (!confirmar || !context.mounted) {
                return;
              }

              context.read<CarritoProvider>().limpiarCarrito();
              context.read<PedidoProvider>().limpiar();
              context.read<DireccionProvider>().limpiar();
              context.read<PerfilProvider>().limpiar();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => Login(),
                ),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
            label: const Text('Cerrar sesión'),
          ),
        ],
      ),
    );
  }

  Future<bool> mostrarConfirmacionCerrarSesion(
    BuildContext context,
  ) async {
    final resultado = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cerrar sesión'),
          content: const Text(
            '¿Estás seguro de que deseas cerrar tu sesión?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Cerrar sesión'),
            ),
          ],
        );
      },
    );

    return resultado ?? false;
  }
}
