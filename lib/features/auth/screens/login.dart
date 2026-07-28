import 'package:demo_app/core/core.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _authService = AuthService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _mostrarPassword = false;
  bool _iniciandoSesion = false;

  Future<void> _login() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _iniciandoSesion = true;
    });

    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    final loginCorrecto = await _authService.login(
      username,
      password,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _iniciandoSesion = false;
    });

    if (loginCorrecto) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const CategoriasScreen(),
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
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.spacingMd,
                vertical: AppSizes.spacingLg,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - (AppSizes.spacingLg * 2),
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 420,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: Image.asset(
                              'assets/img/logo.png',
                              width: 420,
                              height: 180,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(
                            height: AppSizes.spacingLg,
                          ),
                          Text(
                            'Bienvenido',
                            textAlign: TextAlign.center,
                            style: textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: AppSizes.spacingSm,
                          ),
                          Text(
                            'Inicia sesión para realizar tu pedido',
                            textAlign: TextAlign.center,
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(
                            height: AppSizes.spacingLg,
                          ),
                          TextFormField(
                            controller: _usernameController,
                            textInputAction: TextInputAction.next,
                            autofillHints: const [
                              AutofillHints.username,
                            ],
                            decoration: const InputDecoration(
                              labelText: 'Usuario',
                              prefixIcon: Icon(
                                Icons.person_outline,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Ingresa tu usuario';
                              }

                              return null;
                            },
                          ),
                          const SizedBox(
                            height: AppSizes.spacingMd,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: !_mostrarPassword,
                            textInputAction: TextInputAction.done,
                            autofillHints: const [
                              AutofillHints.password,
                            ],
                            onFieldSubmitted: (_) {
                              if (!_iniciandoSesion) {
                                _login();
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              prefixIcon: const Icon(
                                Icons.lock_outline,
                              ),
                              suffixIcon: IconButton(
                                tooltip: _mostrarPassword
                                    ? 'Ocultar contraseña'
                                    : 'Mostrar contraseña',
                                onPressed: () {
                                  setState(() {
                                    _mostrarPassword = !_mostrarPassword;
                                  });
                                },
                                icon: Icon(
                                  _mostrarPassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingresa tu contraseña';
                              }

                              return null;
                            },
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => RecuperarCuenta(),
                                  ),
                                );
                              },
                              child: const Text(
                                '¿Olvidaste tu contraseña?',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: AppSizes.spacingSm,
                          ),
                          SizedBox(
                            height: AppSizes.buttonHeight,
                            child: ElevatedButton(
                              onPressed: _iniciandoSesion ? null : _login,
                              child: _iniciandoSesion
                                  ? const SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                      ),
                                    )
                                  : const Text(
                                      'Iniciar sesión',
                                    ),
                            ),
                          ),
                          const SizedBox(
                            height: AppSizes.spacingMd,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '¿Aún no tienes cuenta?',
                                style: textTheme.bodyMedium,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => RegistroCliente(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Regístrate',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
