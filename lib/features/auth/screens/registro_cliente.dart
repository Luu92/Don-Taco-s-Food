import 'package:flutter/material.dart';

class RegistroCliente extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  RegistroCliente({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Widget padre: Scaffold
      appBar: AppBar(
        title: const Text('Registro de Cliente'),
      ),
      body: Center(
        // Widget hijo: Center
        child: SingleChildScrollView(
          // Widget hijo: SingleChildScrollView
          child: Padding(
            // Widget hijo: Padding
            padding: const EdgeInsets.all(16.0),
            child: Column(
              // Widget hijo: Column
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Regístrate',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                    height: 20), // Espaciador entre el título y el formulario
                Form(
                  // Widget hijo: Form
                  key: _formKey,
                  child: Column(
                    // Sub-hijo: Column dentro de Form
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Nombre',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu nombre';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10), // Espaciador
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Correo Electrónico',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu correo electrónico';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10), // Espaciador
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Contraseña',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu contraseña';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10), // Espaciador
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Confirmar Contraseña',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor confirma tu contraseña';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20), // Espaciador
                      ElevatedButton(
                        // Widget hijo: ElevatedButton
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Procesar datos
                            print('Formulario válido');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.yellow,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                        ),
                        child: const Text('Registrar'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
