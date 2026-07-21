import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/perfil_provider.dart';

class EditarPerfilScreen extends StatefulWidget {
  const EditarPerfilScreen({
    super.key,
  });

  @override
  State<EditarPerfilScreen> createState() => _EditarPerfilScreenState();
}

class _EditarPerfilScreenState extends State<EditarPerfilScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nombreController;
  late final TextEditingController correoController;
  late final TextEditingController telefonoController;

  @override
  void initState() {
    super.initState();

    final perfilProvider = context.read<PerfilProvider>();
    final perfil = perfilProvider.perfil;

    nombreController = TextEditingController(
      text: perfil?.nombre ?? '',
    );

    correoController = TextEditingController(
      text: perfil?.correo ?? '',
    );

    telefonoController = TextEditingController(
      text: perfil?.telefono ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar perfil'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: nombreController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
              validator: (valor) {
                if (valor == null || valor.trim().isEmpty) {
                  return 'Ingresa tu nombre';
                }

                if (valor.trim().length < 3) {
                  return 'El nombre es demasiado corto';
                }

                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: correoController,
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                prefixIcon: Icon(Icons.email_outlined),
                helperText:
                    'El correo utilizado para iniciar sesión no puede modificarse.',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: telefonoController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: const InputDecoration(
                labelText: 'Número telefónico',
                prefixIcon: Icon(Icons.phone_outlined),
                border: OutlineInputBorder(),
                counterText: '',
              ),
              validator: (valor) {
                final telefono = valor?.trim() ?? '';

                if (telefono.isEmpty) {
                  return 'Ingresa tu número telefónico';
                }

                if (!RegExp(r'^\d{10}$').hasMatch(telefono)) {
                  return 'Ingresa un número de 10 dígitos';
                }

                return null;
              },
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _guardarCambios,
              icon: const Icon(Icons.save_outlined),
              label: const Text('Guardar cambios'),
            ),
          ],
        ),
      ),
    );
  }

  void _guardarCambios() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.read<PerfilProvider>().actualizarPerfil(
          nombre: nombreController.text.trim(),
          telefono: telefonoController.text.trim(),
        );

    Navigator.pop(context, true);
  }

  @override
  void dispose() {
    nombreController.dispose();
    correoController.dispose();
    telefonoController.dispose();

    super.dispose();
  }
}
