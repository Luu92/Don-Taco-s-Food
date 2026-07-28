import 'package:demo_app/core/core.dart';

class RegistroCliente extends StatefulWidget {
  const RegistroCliente({super.key});

  @override
  State<RegistroCliente> createState() => _RegistroClienteState();
}

class _RegistroClienteState extends State<RegistroCliente> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nombreController = TextEditingController();

  final TextEditingController _correoController = TextEditingController();

  final TextEditingController _telefonoController = TextEditingController();

  final TextEditingController _contrasenaController = TextEditingController();

  final TextEditingController _confirmarContrasenaController =
      TextEditingController();

  bool _mostrarContrasena = false;
  bool _mostrarConfirmarContrasena = false;
  bool _registrando = false;

  @override
  void dispose() {
    _nombreController.dispose();
    _correoController.dispose();
    _telefonoController.dispose();
    _contrasenaController.dispose();
    _confirmarContrasenaController.dispose();
    super.dispose();
  }

  Future<void> _registrarCliente() async {
    FocusScope.of(context).unfocus();

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _registrando = true;
    });

    // Simulación de la llamada al microservicio.
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _registrando = false;
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text(
            'Cuenta registrada correctamente',
          ),
        ),
      );

    Navigator.pop(context);
  }

  String? _validarNombre(String? value) {
    final nombre = value?.trim() ?? '';

    if (nombre.isEmpty) {
      return 'Ingresa tu nombre';
    }

    if (nombre.length < 3) {
      return 'El nombre debe contener al menos 3 caracteres';
    }

    if (!RegExp(r"^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ\s]+$").hasMatch(nombre)) {
      return 'El nombre solo debe contener letras';
    }

    return null;
  }

  String? _validarCorreo(String? value) {
    final correo = value?.trim() ?? '';

    if (correo.isEmpty) {
      return 'Ingresa tu correo electrónico';
    }

    final expresionCorreo = RegExp(
      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
    );

    if (!expresionCorreo.hasMatch(correo)) {
      return 'Ingresa un correo electrónico válido';
    }

    return null;
  }

  String? _validarTelefono(String? value) {
    final telefono = value?.trim() ?? '';

    if (telefono.isEmpty) {
      return 'Ingresa tu número telefónico';
    }

    if (!RegExp(r'^\d{10}$').hasMatch(telefono)) {
      return 'El teléfono debe contener 10 dígitos';
    }

    return null;
  }

  String? _validarContrasena(String? value) {
    final contrasena = value ?? '';

    if (contrasena.isEmpty) {
      return 'Ingresa una contraseña';
    }

    if (contrasena.length < 8) {
      return 'Debe contener al menos 8 caracteres';
    }

    if (!RegExp(r'[A-Z]').hasMatch(contrasena)) {
      return 'Debe contener al menos una letra mayúscula';
    }

    if (!RegExp(r'[a-z]').hasMatch(contrasena)) {
      return 'Debe contener al menos una letra minúscula';
    }

    if (!RegExp(r'[0-9]').hasMatch(contrasena)) {
      return 'Debe contener al menos un número';
    }

    return null;
  }

  String? _validarConfirmacion(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirma tu contraseña';
    }

    if (value != _contrasenaController.text) {
      return 'Las contraseñas no coinciden';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Crear cuenta',
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(
              AppSizes.spacingMd,
            ),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              Container(
                padding: const EdgeInsets.all(
                  AppSizes.spacingLg,
                ),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(
                    AppSizes.radiusLarge,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 82,
                      height: 82,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.secondary.withOpacity(0.50),
                        ),
                      ),
                      child: const Icon(
                        Icons.person_add_alt_1_outlined,
                        size: 40,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(
                      height: AppSizes.spacingMd,
                    ),
                    Text(
                      'Crea tu cuenta',
                      textAlign: TextAlign.center,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(
                      height: AppSizes.spacingSm,
                    ),
                    Text(
                      'Completa tus datos para comenzar '
                      'a realizar pedidos en Don Taco’s.',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: AppSizes.spacingLg,
              ),
              Text(
                'Datos personales',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(
                height: AppSizes.spacingMd,
              ),
              TextFormField(
                controller: _nombreController,
                enabled: !_registrando,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                autofillHints: const [
                  AutofillHints.name,
                ],
                validator: _validarNombre,
                decoration: const InputDecoration(
                  labelText: 'Nombre completo',
                  hintText: 'Ingresa tu nombre',
                  prefixIcon: Icon(
                    Icons.person_outline_rounded,
                  ),
                ),
              ),
              const SizedBox(
                height: AppSizes.spacingMd,
              ),
              TextFormField(
                controller: _correoController,
                enabled: !_registrando,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autocorrect: false,
                autofillHints: const [
                  AutofillHints.email,
                ],
                validator: _validarCorreo,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  hintText: 'ejemplo@correo.com',
                  prefixIcon: Icon(
                    Icons.email_outlined,
                  ),
                ),
              ),
              const SizedBox(
                height: AppSizes.spacingMd,
              ),
              TextFormField(
                controller: _telefonoController,
                enabled: !_registrando,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                maxLength: 10,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                autofillHints: const [
                  AutofillHints.telephoneNumber,
                ],
                validator: _validarTelefono,
                decoration: const InputDecoration(
                  labelText: 'Número telefónico',
                  hintText: '10 dígitos',
                  prefixIcon: Icon(
                    Icons.phone_outlined,
                  ),
                  counterText: '',
                ),
              ),
              const SizedBox(
                height: AppSizes.spacingLg,
              ),
              Text(
                'Contraseña',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(
                height: AppSizes.spacingMd,
              ),
              TextFormField(
                controller: _contrasenaController,
                enabled: !_registrando,
                obscureText: !_mostrarContrasena,
                textInputAction: TextInputAction.next,
                autofillHints: const [
                  AutofillHints.newPassword,
                ],
                validator: _validarContrasena,
                onChanged: (_) {
                  if (_confirmarContrasenaController.text.isNotEmpty) {
                    _formKey.currentState?.validate();
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  hintText: 'Mínimo 8 caracteres',
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                  ),
                  suffixIcon: IconButton(
                    tooltip: _mostrarContrasena
                        ? 'Ocultar contraseña'
                        : 'Mostrar contraseña',
                    onPressed: _registrando
                        ? null
                        : () {
                            setState(() {
                              _mostrarContrasena = !_mostrarContrasena;
                            });
                          },
                    icon: Icon(
                      _mostrarContrasena
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: AppSizes.spacingMd,
              ),
              TextFormField(
                controller: _confirmarContrasenaController,
                enabled: !_registrando,
                obscureText: !_mostrarConfirmarContrasena,
                textInputAction: TextInputAction.done,
                autofillHints: const [
                  AutofillHints.newPassword,
                ],
                validator: _validarConfirmacion,
                onFieldSubmitted: (_) {
                  if (!_registrando) {
                    _registrarCliente();
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Confirmar contraseña',
                  hintText: 'Escribe nuevamente tu contraseña',
                  prefixIcon: const Icon(
                    Icons.lock_reset_outlined,
                  ),
                  suffixIcon: IconButton(
                    tooltip: _mostrarConfirmarContrasena
                        ? 'Ocultar contraseña'
                        : 'Mostrar contraseña',
                    onPressed: _registrando
                        ? null
                        : () {
                            setState(() {
                              _mostrarConfirmarContrasena =
                                  !_mostrarConfirmarContrasena;
                            });
                          },
                    icon: Icon(
                      _mostrarConfirmarContrasena
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: AppSizes.spacingSm,
              ),
              const Text(
                'La contraseña debe tener al menos 8 caracteres, '
                'una mayúscula, una minúscula y un número.',
                style: TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(
                height: AppSizes.spacingLg,
              ),
              SizedBox(
                width: double.infinity,
                height: AppSizes.buttonHeight,
                child: ElevatedButton.icon(
                  onPressed: _registrando ? null : _registrarCliente,
                  icon: _registrando
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(
                          Icons.person_add_alt_1_outlined,
                        ),
                  label: Text(
                    _registrando ? 'Creando cuenta...' : 'Crear cuenta',
                  ),
                ),
              ),
              const SizedBox(
                height: AppSizes.spacingLg,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
