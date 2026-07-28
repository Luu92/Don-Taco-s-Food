import 'package:demo_app/core/core.dart';

class AlimentosScreen extends StatefulWidget {
  final Categoria categoriaSeleccionada;

  const AlimentosScreen({
    super.key,
    required this.categoriaSeleccionada,
  });

  @override
  State<AlimentosScreen> createState() => _AlimentosScreenState();
}

class _AlimentosScreenState extends State<AlimentosScreen> {
  final AlimentoService _alimentoService = AlimentoService();

  String filtroSeleccionado = 'Lo más vendido';

  final List<Categoria> categorias = CategoriaService().obtenerCategorias();

  late Categoria categoriaActual;

  List<Alimento> alimentos = [];

  final Map<int, int> cantidadesSeleccionadas = {};

  @override
  void initState() {
    super.initState();

    categoriaActual = widget.categoriaSeleccionada;
    alimentos = _alimentoService.obtenerAlimentos();

    for (final alimento in alimentos) {
      cantidadesSeleccionadas[alimento.id] = 1;
    }
  }

  void actualizarCategoria(Categoria nuevaCategoria) {
    setState(() {
      categoriaActual = nuevaCategoria;

      // Reinicia los contadores al cambiar de categoría.
      for (final alimento in alimentos) {
        cantidadesSeleccionadas[alimento.id] = 1;
      }
    });
  }

  void incrementarCantidad(int alimentoId) {
    setState(() {
      cantidadesSeleccionadas[alimentoId] =
          (cantidadesSeleccionadas[alimentoId] ?? 1) + 1;
    });
  }

  void disminuirCantidad(int alimentoId) {
    final cantidadActual = cantidadesSeleccionadas[alimentoId] ?? 1;

    if (cantidadActual <= 1) {
      return;
    }

    setState(() {
      cantidadesSeleccionadas[alimentoId] = cantidadActual - 1;
    });
  }

  List<Alimento> obtenerAlimentosFiltrados() {
    final resultado = alimentos
        .where(
          (alimento) => alimento.idCategoria == categoriaActual.id,
        )
        .toList();

    switch (filtroSeleccionado) {
      case 'Menor precio':
        resultado.sort(
          (a, b) => a.precio.compareTo(b.precio),
        );
        break;

      case 'Mayor precio':
        resultado.sort(
          (a, b) => b.precio.compareTo(a.precio),
        );
        break;

      case 'Lo más vendido':
        resultado.sort(
          (a, b) => b.ranking.compareTo(a.ranking),
        );
        break;
    }

    return resultado;
  }

  bool tienePromocion(Alimento alimento) {
    return alimento.nombre.trim().toLowerCase() == 'taco al pastor';
  }

  void agregarAlCarrito(Alimento alimento) {
    final cantidad = cantidadesSeleccionadas[alimento.id] ?? 1;

    context.read<CarritoProvider>().agregarAlimento({
      'nombre': alimento.nombre,
      'precio': alimento.precio,
      'cantidad': cantidad,
    });

    setState(() {
      cantidadesSeleccionadas[alimento.id] = 1;
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            '$cantidad ${cantidad == 1 ? 'producto agregado' : 'productos agregados'} al carrito',
          ),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final alimentosFiltrados = obtenerAlimentosFiltrados();

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(categoriaActual.nombre),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Categorías
            SizedBox(
              height: 58,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.spacingMd,
                  vertical: AppSizes.spacingSm,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: categorias.length,
                separatorBuilder: (_, __) => const SizedBox(
                  width: AppSizes.spacingSm,
                ),
                itemBuilder: (context, index) {
                  final categoria = categorias[index];

                  final esSeleccionada = categoria.id == categoriaActual.id;

                  return ChoiceChip(
                    label: Text(categoria.nombre),
                    selected: esSeleccionada,
                    showCheckmark: false,
                    selectedColor: AppColors.primary,
                    backgroundColor: AppColors.surface,
                    side: BorderSide(
                      color:
                          esSeleccionada ? AppColors.primary : AppColors.border,
                    ),
                    labelStyle: TextStyle(
                      color:
                          esSeleccionada ? Colors.white : AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppSizes.radiusLarge,
                      ),
                    ),
                    onSelected: (seleccionada) {
                      if (seleccionada) {
                        actualizarCategoria(categoria);
                      }
                    },
                  );
                },
              ),
            ),

            const Divider(height: 1),

            // Encabezado y filtro
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.spacingMd,
                AppSizes.spacingMd,
                AppSizes.spacingMd,
                AppSizes.spacingSm,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          categoriaActual.nombre,
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(
                          height: AppSizes.spacingXs,
                        ),
                        Text(
                          '${alimentosFiltrados.length} opciones disponibles',
                          style: textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: AppSizes.spacingMd,
                  ),
                  SizedBox(
                    width: 155,
                    child: DropdownButtonFormField<String>(
                      value: filtroSeleccionado,
                      isExpanded: true,
                      decoration: const InputDecoration(
                        labelText: 'Ordenar',
                        prefixIcon: Icon(
                          Icons.sort_rounded,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Lo más vendido',
                          child: Text(
                            'Más vendido',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'Menor precio',
                          child: Text(
                            'Menor precio',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'Mayor precio',
                          child: Text(
                            'Mayor precio',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                      onChanged: (valor) {
                        if (valor == null) {
                          return;
                        }

                        setState(() {
                          filtroSeleccionado = valor;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Lista de alimentos
            Expanded(
              child: alimentosFiltrados.isEmpty
                  ? const _AlimentosVacios()
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(
                        AppSizes.spacingMd,
                        AppSizes.spacingSm,
                        AppSizes.spacingMd,
                        AppSizes.spacingLg,
                      ),
                      itemCount: alimentosFiltrados.length,
                      separatorBuilder: (_, __) => const SizedBox(
                        height: AppSizes.spacingMd,
                      ),
                      itemBuilder: (context, index) {
                        final alimento = alimentosFiltrados[index];

                        final cantidad =
                            cantidadesSeleccionadas[alimento.id] ?? 1;

                        return Card(
                          margin: EdgeInsets.zero,
                          clipBehavior: Clip.antiAlias,
                          child: Padding(
                            padding: const EdgeInsets.all(
                              AppSizes.spacingSm,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        AppSizes.radiusMedium,
                                      ),
                                      child: SizedBox(
                                        width: 115,
                                        height: 175,
                                        child: Image.asset(
                                          alimento.foto,
                                          fit: BoxFit.cover,
                                          errorBuilder: (
                                            context,
                                            error,
                                            stackTrace,
                                          ) {
                                            return Container(
                                              color: AppColors.background,
                                              alignment: Alignment.center,
                                              child: const Icon(
                                                Icons.broken_image_outlined,
                                                size: 42,
                                                color: AppColors.textSecondary,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    if (tienePromocion(
                                      alimento,
                                    ))
                                      Positioned(
                                        top: 8,
                                        left: 8,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 9,
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.secondary,
                                            borderRadius: BorderRadius.circular(
                                              AppSizes.radiusSmall,
                                            ),
                                          ),
                                          child: const Text(
                                            '2×1',
                                            style: TextStyle(
                                              color: AppColors.textPrimary,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(
                                  width: AppSizes.spacingMd,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        alimento.nombre,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),

                                      const SizedBox(
                                        height: AppSizes.spacingXs,
                                      ),

                                      Text(
                                        alimento.descripcion,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          height: 1.35,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),

                                      const SizedBox(
                                        height: AppSizes.spacingSm,
                                      ),

                                      Text(
                                        '\$${alimento.precio.toStringAsFixed(0)}',
                                        style: const TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.w800,
                                          color: AppColors.primary,
                                        ),
                                      ),

                                      const SizedBox(
                                        height: AppSizes.spacingSm,
                                      ),

                                      // Selector de cantidad
                                      Container(
                                        height: 38,
                                        decoration: BoxDecoration(
                                          color: AppColors.background,
                                          borderRadius: BorderRadius.circular(
                                            AppSizes.radiusMedium,
                                          ),
                                          border: Border.all(
                                            color: AppColors.border,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              tooltip: 'Disminuir',
                                              padding: EdgeInsets.zero,
                                              constraints: const BoxConstraints(
                                                minWidth: 38,
                                                minHeight: 38,
                                              ),
                                              onPressed: cantidad > 1
                                                  ? () {
                                                      disminuirCantidad(
                                                        alimento.id,
                                                      );
                                                    }
                                                  : null,
                                              icon: const Icon(
                                                Icons.remove,
                                                size: 19,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 26,
                                              child: Text(
                                                '$cantidad',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              tooltip: 'Aumentar',
                                              padding: EdgeInsets.zero,
                                              constraints: const BoxConstraints(
                                                minWidth: 38,
                                                minHeight: 38,
                                              ),
                                              onPressed: () {
                                                incrementarCantidad(
                                                  alimento.id,
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.add,
                                                size: 19,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(
                                        height: AppSizes.spacingSm,
                                      ),

                                      SizedBox(
                                        width: double.infinity,
                                        height: 42,
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            agregarAlCarrito(
                                              alimento,
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.add_shopping_cart_rounded,
                                            size: 19,
                                          ),
                                          label: const Text(
                                            'Agregar',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AlimentosVacios extends StatelessWidget {
  const _AlimentosVacios();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(
          AppSizes.spacingLg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.no_food_outlined,
              size: 60,
              color: AppColors.textSecondary,
            ),
            SizedBox(
              height: AppSizes.spacingMd,
            ),
            Text(
              'No hay alimentos disponibles',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(
              height: AppSizes.spacingXs,
            ),
            Text(
              'Prueba seleccionando otra categoría.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
