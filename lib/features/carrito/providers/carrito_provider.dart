import 'package:flutter/material.dart';

class CarritoProvider extends ChangeNotifier {
  final Map<String, Map<String, dynamic>> _items = {};

  Map<String, Map<String, dynamic>> get items => _items;

  void agregarAlimento(Map<String, dynamic> alimento) {
    final nombre = alimento['nombre'];
    if (_items.containsKey(nombre)) {
      _items[nombre]!['cantidad'] += alimento['cantidad'];
    } else {
      _items[nombre] = Map<String, dynamic>.from(alimento);
    }
    //SOLO PARA VER EL CONTENIDO DEL CARRITO DESPUES DE AGRGAR COSAS
    print("Contenido del carrito: $_items");
    notifyListeners();
  }

  void incrementarCantidad(String nombre) {
    if (_items.containsKey(nombre)) {
      _items[nombre]!['cantidad']++;
      notifyListeners();
    }
  }

  void disminuirCantidad(String nombre) {
    if (!_items.containsKey(nombre)) return;

    if (_items[nombre]!['cantidad'] > 1) {
      _items[nombre]!['cantidad']--;
    } else {
      _items.remove(nombre);
    }
    notifyListeners();
  }

  void eliminarProducto(String nombre) {
    _items.remove(nombre);
    notifyListeners();
  }

  int cantidadEntregada(Map<String, dynamic> item) {
    if (item['nombre'] == 'Taco al Pastor') {
      return item['cantidad'] * 2;
    }
    return item['cantidad'];
  }

  double get total {
    double suma = 0;
    for (final item in _items.values) {
      suma += item['precio'] * item['cantidad'];
    }
    return suma;
  }

  void limpiarCarrito() {
    _items.clear();
    notifyListeners();
  }

  int get cantidadProductos {
    int total = 0;

    for (final item in _items.values) {
      total += item['cantidad'] as int;
    }

    return total;
  }
}
