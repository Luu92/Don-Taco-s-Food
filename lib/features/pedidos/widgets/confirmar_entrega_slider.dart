import 'package:demo_app/core/core.dart';

class ConfirmarEntregaSlider extends StatefulWidget {
  final Future<void> Function() onConfirmar;

  const ConfirmarEntregaSlider({
    super.key,
    required this.onConfirmar,
  });

  @override
  State<ConfirmarEntregaSlider> createState() => _ConfirmarEntregaSliderState();
}

class _ConfirmarEntregaSliderState extends State<ConfirmarEntregaSlider> {
  double _posicion = 0;

  bool _procesando = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const double botonSize = 52;

        final anchoDisponible = constraints.maxWidth - botonSize;

        return Container(
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.secondary.withOpacity(0.14),
            borderRadius: BorderRadius.circular(
              AppSizes.radiusLarge,
            ),
            border: Border.all(
              color: AppColors.secondary.withOpacity(0.45),
            ),
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 60,
                  ),
                  child: Text(
                    'Desliza para confirmar entrega',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: _posicion,
                child: GestureDetector(
                  onHorizontalDragUpdate: _procesando
                      ? null
                      : (details) {
                          setState(() {
                            _posicion += details.delta.dx;

                            if (_posicion < 0) {
                              _posicion = 0;
                            }

                            if (_posicion > anchoDisponible) {
                              _posicion = anchoDisponible;
                            }
                          });
                        },
                  onHorizontalDragEnd: _procesando
                      ? null
                      : (_) async {
                          final porcentaje = anchoDisponible == 0
                              ? 0
                              : _posicion / anchoDisponible;

                          if (porcentaje >= 0.8) {
                            setState(() {
                              _procesando = true;
                              _posicion = anchoDisponible;
                            });

                            await widget.onConfirmar();

                            if (!mounted) {
                              return;
                            }

                            setState(() {
                              _procesando = false;
                              _posicion = 0;
                            });
                          } else {
                            setState(() {
                              _posicion = 0;
                            });
                          }
                        },
                  child: Container(
                    width: botonSize,
                    height: botonSize,
                    margin: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: _procesando
                        ? const Padding(
                            padding: EdgeInsets.all(15),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                          ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
