import 'package:demo_app/models/categoria.dart';

class CategoriaService {
  List<Categoria> obtenerCategorias() {
    return [
      Categoria(id: 1, nombre: 'Tacos', imagen: 'assets/img/logo.png'),
      Categoria(id: 2, nombre: 'Tortas', imagen: 'assets/img/logo.png'),
      Categoria(id: 3, nombre: 'Especiales', imagen: 'assets/img/logo.png'),
      Categoria(id: 4, nombre: 'Alambres', imagen: 'assets/img/logo.png')
    ];
  }
}
