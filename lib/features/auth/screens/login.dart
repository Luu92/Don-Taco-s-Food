import 'package:demo_app/features/menu/screens/categorias_screen.dart';
import 'package:demo_app/features/auth/screens/recuperar_cuenta.dart';
import 'package:demo_app/features/auth/screens/registro_cliente.dart';
import 'package:demo_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
  final AuthService _authService = AuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {

  final username = _usernameController.text;
  final password = _passwordController.text;

  final loginCorrecto =
      await _authService.login(
        username,
        password,
      );

  if (loginCorrecto) {

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CategoriasScreen(),
      ),
    );

  } else {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Usuario o contraseña incorrectos',
        ),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Image.asset('assets/img/logo.png'),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Usuario',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Contraseña',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Lógica para recuperar la contraseña
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RecuperarCuenta()),
                            );
                          },
                          child: const Text('¿Olvidaste tu contraseña?'),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.yellow,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                        ),
                        onPressed: _login,
                        child: const Text('Iniciar Sesión'),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          // Lógica para registrarse
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegistroCliente()),
                          );
                        },
                        child: const Text('Registrarse'),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose(){
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
