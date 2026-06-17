import 'package:demo_app/features/carrito/providers/carrito_provider.dart';
import 'package:demo_app/features/carrito/screens/carrito_screen.dart';
import 'package:demo_app/features/widgets/bottom_nav_bar.dart';
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
  int _currentIndex = 0;

  List<Alimento> alimentos = [];

  @override
  void initState() {
    super.initState();
    categoriaActual = widget.categoriaSeleccionada;
    alimentos = _alimentoService.obtenerAlimentos();
  }

  void actualizarCategoria(Categoria nuevaCategoria) {
    setState(() {
      categoriaActual = nuevaCategoria;
    });
  }

  void _onNavBarTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // void _incrementarCantidad(int index) {
  //   setState(() {
  //     alimentos[index]['cantidad']++;
  //   });
  // }

  // void _disminuirCantidad(int index) {
  //   setState(() {
  //     if (alimentos[index]['cantidad'] > 1) {
  //       alimentos[index]['cantidad']--;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final alimentosFiltrados = alimentos
        .where((alimento) => alimento.idCategoria == categoriaActual.id)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoriaActual.nombre),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart),
                Positioned(
                  right: 0,
                  child: Consumer<CarritoProvider>(
                    builder: (context, carrito, child) {
                      if (carrito.cantidadProductos == 0) {
                        return const SizedBox();
                      }

                      return Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${carrito.cantidadProductos}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CarritoScreen(),
                ),
              );
            },
          ),
        ],
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
                    categorias[index].nombre == categoriaActual;
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
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 160,
                    child: Row(
                      children: [
                        Image.asset(
                          alimentosFiltrados[index].foto,
                          width: 80,
                          height: 80,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                alimentosFiltrados[index].nombre,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "\$${alimentosFiltrados[index].precio}",
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      // IconButton(
                                      //   icon: const Icon(Icons.remove),
                                      //   onPressed:
                                      //       alimentos[index]['cantidad'] > 1
                                      //           ? () =>
                                      //               _disminuirCantidad(index)
                                      //           : null,
                                      // ),
                                      // Text("${alimentos[index]['cantidad']}"),
                                      // IconButton(
                                      //   icon: const Icon(Icons.add),
                                      //   onPressed: () =>
                                      //       _incrementarCantidad(index),
                                      // ),
                                    ],
                                  ),

                                  // 🔹 Botón conectado al Provider
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.yellow),
                                    onPressed: () {
                                      Provider.of<CarritoProvider>(context,
                                              listen: false)
                                          .agregarAlimento({
                                        'nombre':
                                            alimentosFiltrados[index].nombre,
                                        'precio':
                                            alimentosFiltrados[index].precio,
                                        'cantidad': 1,
                                      });
                                    },
                                    child: const Text('Agregar'),
                                  ),
                                ],
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
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavBarTapped,
      ),
    );
  }
}
