import 'package:flutter/material.dart';
import 'package:demo_app/features/cuenta/services/perfil_service.dart';
import 'package:demo_app/models/usuario.dart';

class PerfilProvider extends ChangeNotifier {
  final PerfilService _perfilService;
  PerfilProvider({
    PerfilService? perfilService,
  }) : _perfilService = perfilService ?? PerfilService() {
    cargarPerfil();
  }

  Usuario? _perfil;

  Usuario? get perfil => _perfil;

  void cargarPerfil() {
    _perfil = _perfilService.obtenerPerfil();
    notifyListeners();
  }

  void actualizarPerfil({
    required String nombre,
    required String telefono,
  }) {
    _perfil = _perfilService.actualizarPerfil(
      nombre: nombre,
      telefono: telefono,
    );

    notifyListeners();
  }

  void limpiar() {
    _perfil = null;
    notifyListeners();
  }
}
