import 'package:demo_app/models/usuario.dart';

class PerfilService {
  Usuario obtenerPerfil() {
    return Usuario(
      id: 1,
      nombre: "Juan Pérez",
      correo: "test@gmail.com",
    );
  }
}
