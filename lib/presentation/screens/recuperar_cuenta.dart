import 'package:flutter/material.dart';

class RecuperarCuenta extends StatefulWidget {
  const RecuperarCuenta({super.key});

  @override
  _RecuperarContrasenaState createState() => _RecuperarContrasenaState();
}

class _RecuperarContrasenaState extends State<RecuperarCuenta> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  bool _isEmailValid = false;

  Future<void> _validateEmail() async {
    // Simula una llamada al microservicio
    await Future.delayed(const Duration(seconds: 1));

    // Aquí iría la lógica real para validar el correo con el microservicio.
    // Por ejemplo, podrías hacer una petición HTTP para verificar si el correo existe.
    // Por ahora, simularemos que si el correo es "test@example.com" es válido.

    if (_emailController.text == "test@example.com") {
      setState(() {
        _isEmailValid = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Correo válido. Ahora puede cambiar la contraseña.')),
      );
    } else {
      setState(() {
        _isEmailValid = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Correo inexistente.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar contraseña'),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Datos personales',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.yellow,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: _validateEmail,
              child: const Text('Validar'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _newPasswordController,
              decoration: const InputDecoration(
                labelText: 'Nueva contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              enabled: _isEmailValid, // Solo habilitado si el correo es válido
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _repeatPasswordController,
              decoration: const InputDecoration(
                labelText: 'Repetir contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              enabled: _isEmailValid, // Solo habilitado si el correo es válido
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.yellow,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: _isEmailValid
                  ? () {
                      // Lógica para guardar la nueva contraseña
                    }
                  : null, // Deshabilitado hasta que el correo sea válido
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
