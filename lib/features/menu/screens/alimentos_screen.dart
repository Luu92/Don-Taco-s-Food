import 'package:demo_app/features/carrito/providers/carrito_provider.dart';
import 'package:demo_app/models/alimento.dart';
import 'package:demo_app/models/categoria.dart';
import 'package:demo_app/services/alimento_service.dart';
import 'package:demo_app/services/categoria_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlimentosScreen extends StatefulWidget {
  final Categoria categoriaSeleccionada;

  const AlimentosScreen({super.key, required this.categoriaSeleccionada});

  @override
  _AlimentosScreenState createState() => _AlimentosScreenState();
}

class _AlimentosScreenState extends State<AlimentosScreen> {
  final AlimentoService _alimentoService = AlimentoService();
  String filtroSeleccionado = 'Lo más vendido';
  List<Categoria> categorias = CategoriaService().obtenerCategorias();
  late Categoria categoriaActual;

  List<Alimento> alimentos = [];
  Map<int, int> cantidadesSeleccionadas = {};

  @override
  void initState() {
    super.initState();
    categoriaActual = widget.categoriaSeleccionada;
    alimentos = _alimentoService.obtenerAlimentos();
    for (var alimento in alimentos) {
      cantidadesSeleccionadas[alimento.id] = 1;
    }
  }

  void actualizarCategoria(Categoria nuevaCategoria) {
    setState(() {
      categoriaActual = nuevaCategoria;
    });
  }

  void incrementarCantidad(int alimentoId) {
    setState(() {
      cantidadesSeleccionadas[alimentoId] =
          (cantidadesSeleccionadas[alimentoId] ?? 1) + 1;
    });
  }

  void disminuirCantidad(int alimentoId) {
    setState(() {
      if ((cantidadesSeleccionadas[alimentoId] ?? 1) > 1) {
        cantidadesSeleccionadas[alimentoId] =
            cantidadesSeleccionadas[alimentoId]! - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final alimentosFiltrados = alimentos
        .where((alimento) => alimento.idCategoria == categoriaActual.id)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoriaActual.nombre),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Menú de Categorías
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categorias.length,
              itemBuilder: (context, index) {
                bool esSeleccionado =
                    categorias[index].nombre == categoriaActual.nombre;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ChoiceChip(
                    label: Text(categorias[index].nombre),
                    selected: esSeleccionado,
                    onSelected: (seleccionado) {
                      if (seleccionado) {
                        actualizarCategoria(categorias[index]);
                      }
                    },
                  ),
                );
              },
            ),
          ),

          // 🔹 Filtro de ordenamiento
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: filtroSeleccionado,
              items: ['Lo más vendido', 'Menor precio', 'Mayor precio']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (valor) {
                setState(() {
                  filtroSeleccionado = valor!;
                });
              },
            ),
          ),

          // 🔹 Lista de Alimentos con tarjetas más altas

          Expanded(
            child: ListView.builder(
              itemCount: alimentosFiltrados.length,
              itemBuilder: (context, index) {
                final alimento = alimentosFiltrados[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: 105,
                            height: 150,
                            child: Image.asset(
                              alimento.foto,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey.shade200,
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.broken_image_outlined,
                                    size: 40,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                alimento.nombre,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                alimento.descripcion,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 13),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '\$${alimento.precio.toStringAsFixed(0)}',
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.deepOrangeAccent),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    constraints: const BoxConstraints(
                                      minWidth: 36,
                                      minHeight: 36,
                                    ),
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      disminuirCantidad(alimento.id);
                                    },
                                  ),
                                  Text(
                                    '${cantidadesSeleccionadas[alimento.id] ?? 1}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    constraints: const BoxConstraints(
                                      minWidth: 36,
                                      minHeight: 36,
                                    ),
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      incrementarCantidad(alimento.id);
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 36,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.yellow,
                                    padding: EdgeInsets.zero,
                                  ),
                                  onPressed: () {
                                    context
                                        .read<CarritoProvider>()
                                        .agregarAlimento({
                                      'nombre': alimento.nombre,
                                      'precio': alimento.precio,
                                      'cantidad': cantidadesSeleccionadas[
                                              alimento.id] ??
                                          1,
                                    });

                                    setState(() {
                                      cantidadesSeleccionadas[alimento.id] = 1;
                                    });
                                  },
                                  child: const Text('Agregar'),
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
    );
  }
}
