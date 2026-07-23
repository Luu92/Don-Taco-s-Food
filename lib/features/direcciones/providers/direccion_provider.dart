import 'package:demo_app/models/direccion.dart';
import 'package:demo_app/services/direccion_service.dart';
import 'package:flutter/material.dart';

class DireccionProvider extends ChangeNotifier {
  List<Direccion> _direcciones = [];
  final DireccionService _direccionService = DireccionService();

  List<Direccion> get direcciones => _direcciones;

  bool get tieneDireccionPrincipal => obtenerDireccionPrincipal() != null;

  bool get tieneDirecciones => _direcciones.isNotEmpty;

  DireccionProvider() {
    _direcciones = _direccionService.obtenerDirecciones();
  }

  void agregarDireccion(Direccion direccion) {
    Direccion nuevaDireccion = Direccion(
        id: 0,
        alias: direccion.alias,
        calle: direccion.calle,
        numero: direccion.numero,
        codigoPostal: direccion.codigoPostal,
        colonia: direccion.colonia,
        idComensal: direccion.idComensal,
        principal: _direcciones.isEmpty);

    _direccionService.agregarDireccion(nuevaDireccion);

    notifyListeners();
  }

  void editarDireccion(Direccion direccion) {
    _direccionService.editarDireccion(direccion);
    final index = _direcciones.indexWhere((d) => d.id == direccion.id);

    if (index != -1) {
      _direcciones[index] = direccion;
    }

    notifyListeners();
  }

  void eliminarDireccion(int idDireccion) {
    _direccionService.eliminarDireccion(idDireccion);

    _direcciones = _direccionService.obtenerDirecciones();

    notifyListeners();
  }

  Direccion? obtenerDireccionPrincipal() {
    if (_direcciones.isEmpty) {
      _direcciones = _direccionService.obtenerDirecciones();
    }

    for (final direccion in _direcciones) {
      if (direccion.principal) {
        return direccion;
      }
    }

    return null;
  }

  void establecerDireccionPrincipal(Direccion direccion) {
    _direccionService.establecerDireccionPrincipal(direccion);
    notifyListeners();
  }

  void limpiar() {
    _direcciones.clear();
    notifyListeners();
  }
}
