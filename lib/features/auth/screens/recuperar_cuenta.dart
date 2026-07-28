import 'package:demo_app/core/core.dart';

class RecuperarCuenta extends StatefulWidget {
  const RecuperarCuenta({super.key});

  @override
  State<RecuperarCuenta> createState() => _RecuperarCuentaState();
}

class _RecuperarCuentaState extends State<RecuperarCuenta> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _telefonoController = TextEditingController();

  final TextEditingController _newPasswordController = TextEditingController();

  final TextEditingController _repeatPasswordController =
      TextEditingController();

  bool _datosValidados = false;
  bool _validandoDatos = false;
  bool _guardandoContrasena = false;

  bool _mostrarNuevaContrasena = false;
  bool _mostrarRepetirContrasena = false;

  @override
  void dispose() {
    _emailController.dispose();
    _telefonoController.dispose();
    _newPasswordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  Future<void> _validarDatos() async {
    FocusScope.of(context).unfocus();

    final correoValido = _validarCorreo(_emailController.text) == null;

    final telefonoValido = _validarTelefono(_telefonoController.text) == null;

    if (!correoValido || !telefonoValido) {
      setState(() {
        _datosValidados = false;
      });

      _formKey.currentState?.validate();
      return;
    }

    setState(() {
      _validandoDatos = true;
      _datosValidados = false;
    });

    // Simulación de la consulta al microservicio.
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (!mounted) {
      return;
    }

    final correoExiste =
        _emailController.text.trim().toLowerCase() == 'test@gmail.com';

    final telefonoCoincide = _telefonoController.text.trim() == '5512345678';

    setState(() {
      _validandoDatos = false;
      _datosValidados = correoExiste && telefonoCoincide;
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            _datosValidados
                ? 'Datos verificados correctamente.'
                : 'El correo y el teléfono no coinciden '
                    'con una cuenta registrada.',
          ),
        ),
      );
  }

  Future<void> _guardarContrasena() async {
    FocusScope.of(context).unfocus();

    if (!_datosValidados) {
      return;
    }

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _guardandoContrasena = true;
    });

    // Aquí se enviará la nueva contraseña
    // al microservicio de usuarios.
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _guardandoContrasena = false;
    });

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return const ContrasenaActualizadaDialog();
      },
    );

    if (!mounted) {
      return;
    }

    Navigator.pop(context);
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
      return 'Ingresa un correo válido';
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

  String? _validarNuevaContrasena(String? value) {
    if (!_datosValidados) {
      return null;
    }

    final contrasena = value ?? '';

    if (contrasena.isEmpty) {
      return 'Ingresa una nueva contraseña';
    }

    if (contrasena.length < 8) {
      return 'Debe contener al menos 8 caracteres';
    }

    if (!RegExp(r'[A-Z]').hasMatch(contrasena)) {
      return 'Agrega al menos una letra mayúscula';
    }

    if (!RegExp(r'[a-z]').hasMatch(contrasena)) {
      return 'Agrega al menos una letra minúscula';
    }

    if (!RegExp(r'[0-9]').hasMatch(contrasena)) {
      return 'Agrega al menos un número';
    }

    return null;
  }

  String? _validarConfirmacion(String? value) {
    if (!_datosValidados) {
      return null;
    }

    if (value == null || value.isEmpty) {
      return 'Repite la nueva contraseña';
    }

    if (value != _newPasswordController.text) {
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
          'Recuperar contraseña',
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
                        Icons.lock_reset_rounded,
                        size: 42,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(
                      height: AppSizes.spacingMd,
                    ),
                    Text(
                      'Recupera el acceso a tu cuenta',
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
                      'Ingresa el correo y teléfono '
                      'registrados en tu cuenta para '
                      'verificar tu identidad.',
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
                'Verificación de cuenta',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(
                height: AppSizes.spacingMd,
              ),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autocorrect: false,
                enabled: !_validandoDatos && !_guardandoContrasena,
                validator: _validarCorreo,
                onChanged: (_) {
                  if (_datosValidados) {
                    setState(() {
                      _datosValidados = false;
                      _newPasswordController.clear();
                      _repeatPasswordController.clear();
                    });
                  }
                },
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
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                maxLength: 10,
                enabled: !_validandoDatos && !_guardandoContrasena,
                validator: _validarTelefono,
                onChanged: (_) {
                  if (_datosValidados) {
                    setState(() {
                      _datosValidados = false;
                      _newPasswordController.clear();
                      _repeatPasswordController.clear();
                    });
                  }
                },
                onFieldSubmitted: (_) {
                  _validarDatos();
                },
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
                height: AppSizes.spacingMd,
              ),
              SizedBox(
                width: double.infinity,
                height: AppSizes.buttonHeight,
                child: ElevatedButton.icon(
                  onPressed: _validandoDatos || _guardandoContrasena
                      ? null
                      : _validarDatos,
                  icon: _validandoDatos
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(
                          Icons.verified_user_outlined,
                        ),
                  label: Text(
                    _validandoDatos ? 'Verificando...' : 'Verificar datos',
                  ),
                ),
              ),
              const SizedBox(
                height: AppSizes.spacingLg,
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: _datosValidados
                    ? const _DatosVerificadosCard(
                        key: ValueKey(
                          'datos-verificados',
                        ),
                      )
                    : const _DatosPendientesCard(
                        key: ValueKey(
                          'datos-pendientes',
                        ),
                      ),
              ),
              const SizedBox(
                height: AppSizes.spacingLg,
              ),
              Text(
                'Nueva contraseña',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: _datosValidados
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                ),
              ),
              const SizedBox(
                height: AppSizes.spacingMd,
              ),
              TextFormField(
                controller: _newPasswordController,
                enabled: _datosValidados && !_guardandoContrasena,
                obscureText: !_mostrarNuevaContrasena,
                textInputAction: TextInputAction.next,
                validator: _validarNuevaContrasena,
                onChanged: (_) {
                  if (_repeatPasswordController.text.isNotEmpty) {
                    _formKey.currentState?.validate();
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Nueva contraseña',
                  hintText: 'Mínimo 8 caracteres',
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                  ),
                  suffixIcon: IconButton(
                    tooltip: _mostrarNuevaContrasena
                        ? 'Ocultar contraseña'
                        : 'Mostrar contraseña',
                    onPressed: !_datosValidados
                        ? null
                        : () {
                            setState(() {
                              _mostrarNuevaContrasena =
                                  !_mostrarNuevaContrasena;
                            });
                          },
                    icon: Icon(
                      _mostrarNuevaContrasena
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
                controller: _repeatPasswordController,
                enabled: _datosValidados && !_guardandoContrasena,
                obscureText: !_mostrarRepetirContrasena,
                textInputAction: TextInputAction.done,
                validator: _validarConfirmacion,
                onFieldSubmitted: (_) {
                  if (_datosValidados) {
                    _guardarContrasena();
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Confirmar nueva contraseña',
                  prefixIcon: const Icon(
                    Icons.lock_reset_outlined,
                  ),
                  suffixIcon: IconButton(
                    tooltip: _mostrarRepetirContrasena
                        ? 'Ocultar contraseña'
                        : 'Mostrar contraseña',
                    onPressed: !_datosValidados
                        ? null
                        : () {
                            setState(() {
                              _mostrarRepetirContrasena =
                                  !_mostrarRepetirContrasena;
                            });
                          },
                    icon: Icon(
                      _mostrarRepetirContrasena
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
                'La contraseña debe tener al menos '
                '8 caracteres, una mayúscula, una '
                'minúscula y un número.',
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
                  onPressed: !_datosValidados || _guardandoContrasena
                      ? null
                      : _guardarContrasena,
                  icon: _guardandoContrasena
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(
                          Icons.save_outlined,
                        ),
                  label: Text(
                    _guardandoContrasena
                        ? 'Guardando...'
                        : 'Guardar contraseña',
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

class _DatosVerificadosCard extends StatelessWidget {
  const _DatosVerificadosCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        AppSizes.spacingMd,
      ),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.10),
        borderRadius: BorderRadius.circular(
          AppSizes.radiusMedium,
        ),
        border: Border.all(
          color: Colors.green.withOpacity(0.35),
        ),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.check_circle_outline_rounded,
            color: Colors.green,
          ),
          SizedBox(
            width: AppSizes.spacingSm,
          ),
          Expanded(
            child: Text(
              'Cuenta verificada. Ya puedes '
              'establecer una nueva contraseña.',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DatosPendientesCard extends StatelessWidget {
  const _DatosPendientesCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        AppSizes.spacingMd,
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(
          AppSizes.radiusMedium,
        ),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: AppColors.textSecondary,
          ),
          SizedBox(
            width: AppSizes.spacingSm,
          ),
          Expanded(
            child: Text(
              'Primero debes verificar tu correo '
              'y número telefónico.',
              style: TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
