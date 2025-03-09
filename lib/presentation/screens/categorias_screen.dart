import 'package:flutter/material.dart';

class CategoriasScreen extends StatelessWidget {
  final List<Map<String, String>> categorias = [
    {'nombre': 'Tacos', 'imagen': 'assets/img/logo.png'},
    {'nombre': 'Tortas', 'imagen': 'assets/img/logo.png'},
    {'nombre': 'Queso', 'imagen': 'assets/img/logo.png'},
    {'nombre': 'Especiales', 'imagen': 'assets/img/logo.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Don Taco’s Food'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Barra de búsqueda
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Buscar',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 16),

            // Grid de Categorías
            Expanded(
              child: GridView.builder(
                itemCount: categorias.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columnas
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1, // Mantiene la proporción cuadrada
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Aquí puedes navegar a la vista de productos de la categoría seleccionada
                      print(
                          "Categoría seleccionada: ${categorias[index]['nombre']}");
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            categorias[index]['imagen']!,
                            height: 80, // Ajusta el tamaño de la imagen
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            categorias[index]['nombre']!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
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

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Indica qué pestaña está seleccionada
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Menú'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Pedidos'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Cuenta'),
        ],
        onTap: (index) {
          // Aquí puedes cambiar la pantalla según la opción seleccionada
          print("Opción seleccionada: $index");
        },
      ),
    );
  }
}
