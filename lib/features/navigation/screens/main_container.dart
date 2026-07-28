import 'package:demo_app/core/core.dart';

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
