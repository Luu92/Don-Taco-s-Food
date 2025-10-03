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
}
