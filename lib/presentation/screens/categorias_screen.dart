import 'package:demo_app/presentation/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'alimentos_screen.dart'; // Importamos la pantalla de alimentos

class CategoriasScreen extends StatefulWidget {
  const CategoriasScreen({super.key});

  @override
  _CategoriasScreenState createState() => _CategoriasScreenState();
}

class _CategoriasScreenState extends State<CategoriasScreen> {
  int _currentIndex = 0; // 🟢 Índice del BottomNavigationBar

  void _onNavBarTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // 🟢 Navegación según la pestaña seleccionada
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CategoriasScreen()),
        );
        break;
      case 1:
        // Aquí iría la pantalla de Pedidos
        break;
      case 2:
        // Aquí iría la pantalla de Cuenta
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Lista de categorías
    List<String> categorias = ['Tacos', 'Especiales', 'Tortas', 'Queso'];

    return Scaffold(
      appBar: AppBar(title: const Text('Don Taco’s Food')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Dos columnas
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
          ),
          itemCount: categorias.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Navegar a la pantalla de alimentos con la categoría seleccionada
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AlimentosScreen(
                      categoriaSeleccionada: categorias[index],
                    ),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/img/logo.png', height: 80),
                    const SizedBox(height: 10),
                    Text(
                      categorias[index],
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),

      // 🟢 Bottom Navigation Bar
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavBarTapped,
      ),
    );
  }
}
