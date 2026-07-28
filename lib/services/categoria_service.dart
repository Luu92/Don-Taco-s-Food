import 'package:demo_app/core/core.dart';

class CategoriaService {
  List<Categoria> obtenerCategorias() {
    return [
      Categoria(id: 1, nombre: 'Tacos', imagen: 'assets/img/taco_pastor.jpg'),
      Categoria(id: 2, nombre: 'Tortas', imagen: 'assets/img/torta_pastor.jpg'),
      Categoria(
          id: 3, nombre: 'Especiales', imagen: 'assets/img/burrito_pastor.jpg'),
      Categoria(
          id: 4, nombre: 'Alambres', imagen: 'assets/img/alambre_pastor.jpg')
    ];
  }
}
