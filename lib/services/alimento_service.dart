import 'package:demo_app/models/alimento.dart';

class AlimentoService {
  List<Alimento> obtenerAlimentos() {
    return [
      Alimento(
        id: 1,
        nombre: 'Taco al Pastor',
        descripcion: 'Tortilla de maíz con pastor',
        precio: 50,
        foto: 'assets/img/logo.png',
        idCategoria: 1,
        ranking: 5,
      ),

      Alimento(
        id: 2,
        nombre: 'Taco de Suadero',
        descripcion: 'Suadero tradicional',
        precio: 55,
        foto: 'assets/img/logo.png',
        idCategoria: 1,
        ranking: 4,
      ),

      Alimento(
        id: 3,
        nombre: 'Torta Suadero',
        descripcion: 'Torta especial',
        precio: 90,
        foto: 'assets/img/logo.png',
        idCategoria: 2,
        ranking: 5,
      ),

      Alimento(
        id: 4,
        nombre: 'Torta Pastor',
        descripcion: 'Torta especial',
        precio: 90,
        foto: 'assets/img/logo.png',
        idCategoria: 2,
        ranking: 5,
      ),
    ];
  }
}