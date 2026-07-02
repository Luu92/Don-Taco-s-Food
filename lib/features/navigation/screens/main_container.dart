import 'package:demo_app/features/cuenta/screens/perfil_screen.dart';
import 'package:demo_app/features/widgets/bottom_nav_bar.dart';
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
      const PerfilScreen(),
    ];

    return Scaffold(
      body: pantallas[currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
