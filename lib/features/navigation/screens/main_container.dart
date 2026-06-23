import 'package:flutter/material.dart';
import 'package:demo_app/models/categoria.dart';
import 'package:demo_app/features/menu/screens/alimentos_screen.dart';
import 'package:demo_app/features/carrito/screens/carrito_screen.dart';

class MainContainer extends StatefulWidget {
  final Categoria categoriaInicial;

  const MainContainer({
    super.key,
    required this.categoriaInicial,
  });

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pantallas = [
      AlimentosScreen(
        categoriaSeleccionada: widget.categoriaInicial,
      ),
      const CarritoScreen(),
      const Center(
        child: Text('Perfil'),
      ),
    ];

    return Scaffold(
      body: pantallas[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Menú',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrito',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Cuenta',
          ),
        ],
      ),
    );
  }
}
