import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:demo_app/features/carrito/providers/carrito_provider.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Menú'),
        BottomNavigationBarItem(
          icon: Consumer<CarritoProvider>(
            builder: (context, carrito, child) {
              return Badge(
                isLabelVisible: carrito.cantidadProductos > 0,
                label: Text('${carrito.cantidadProductos}'),
                child: const Icon(Icons.shopping_cart),
              );
            },
          ),
          label: 'Carrito',
        ),
        const BottomNavigationBarItem(
            icon: Icon(Icons.person), label: 'Cuenta'),
      ],
    );
  }
}
