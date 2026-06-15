import 'package:flutter/material.dart';
import '../pages/food_screen.dart';

class CategoriasScreen extends StatelessWidget {
  const CategoriasScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                // 🚀 Ahora mandamos al MainContainer con el BottomNavBar
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainContainer(
                      initialScreen: AlimentosScreen(
                        categoriaSeleccionada: categorias[index],
                      ),
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
    );
  }
}
