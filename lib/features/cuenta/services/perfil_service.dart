import 'package:demo_app/models/usuario.dart';

class PerfilService {
  Usuario _usuario = Usuario(
      id: 1,
      nombre: "Juan Pérez",
      correo: "test@gmail.com",
      telefono: "5520304050");

  Usuario obtenerPerfil() {
    return _usuario;
  }

  Usuario actualizarPerfil({required String nombre, required String telefono}) {
    _usuario = _usuario.copyWith(nombre: nombre, telefono: telefono);
    return _usuario;
  }
}
