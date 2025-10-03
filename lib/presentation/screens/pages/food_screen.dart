import 'package:demo_app/presentation/providers/carrito_provider.dart';
import 'package:demo_app/presentation/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlimentosScreen extends StatefulWidget {
  final String categoriaSeleccionada;

  const AlimentosScreen({super.key, required this.categoriaSeleccionada});

  @override
  _AlimentosScreenState createState() => _AlimentosScreenState();
}

class _AlimentosScreenState extends State<AlimentosScreen> {
  String filtroSeleccionado = 'Lo más vendido';
  List<String> categorias = ['Tacos', 'Especiales', 'Tortas', 'Queso'];
  late String categoriaActual;
  int _currentIndex = 0;

  List<Map<String, dynamic>> alimentos = [
    {
      'nombre': 'Tacos al Pastor',
      'precio': 50,
      'imagen': 'assets/img/logo.png',
      'cantidad': 1
    },
    {
      'nombre': 'Taco Suadero',
      'precio': 55,
      'imagen': 'assets/img/logo.png',
      'cantidad': 1
    },
  ];

  @override
  void initState() {
    super.initState();
    categoriaActual = widget.categoriaSeleccionada;
  }

  void actualizarCategoria(String nuevaCategoria) {
    setState(() {
      categoriaActual = nuevaCategoria;
    });
  }

  void _onNavBarTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _incrementarCantidad(int index) {
    setState(() {
      alimentos[index]['cantidad']++;
    });
  }

  void _disminuirCantidad(int index) {
    setState(() {
      if (alimentos[index]['cantidad'] > 1) {
        alimentos[index]['cantidad']--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoriaActual),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          )
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
                bool esSeleccionado = categorias[index] == categoriaActual;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ChoiceChip(
                    label: Text(categorias[index]),
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
              itemCount: alimentos.length,
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
                          alimentos[index]['imagen'],
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
                                alimentos[index]['nombre'],
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "\$${alimentos[index]['precio']}",
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed:
                                            alimentos[index]['cantidad'] > 1
                                                ? () =>
                                                    _disminuirCantidad(index)
                                                : null,
                                      ),
                                      Text("${alimentos[index]['cantidad']}"),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () =>
                                            _incrementarCantidad(index),
                                      ),
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
                                        'nombre': alimentos[index]['nombre'],
                                        'precio': alimentos[index]['precio'],
                                        'cantidad': alimentos[index]
                                            ['cantidad'],
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
