import '../models/direccion.dart';

class DireccionService {
  final List<Direccion> _direcciones = [];

  List<Direccion> obtenerDirecciones() {
    return _direcciones;
  }

  void agregarDireccion(Direccion direccion) {
    // Id temporal hasta el momento del backend
    final nuevoId = _direcciones.isEmpty ? 1 : _direcciones.last.id + 1;

    _direcciones.add(
      Direccion(
        id: nuevoId,
        alias: direccion.alias,
        calle: direccion.calle,
        numero: direccion.numero,
        codigoPostal: direccion.codigoPostal,
        colonia: direccion.colonia,
        idComensal: direccion.idComensal,
        principal: direccion.principal,
      ),
    );
  }

  void editarDireccion(Direccion direccion) {
    final index = _direcciones.indexWhere(
      (d) => d.id == direccion.id,
    );

    if (index != -1) {
      _direcciones[index] = direccion;
    }
  }

  void establecerDireccionPrincipal(Direccion direccionSeleccionada) {
    for (int i = 0; i < _direcciones.length; i++) {
      final direccionActual = _direcciones[i];

      _direcciones[i] = Direccion(
        id: direccionActual.id,
        alias: direccionActual.alias,
        calle: direccionActual.calle,
        numero: direccionActual.numero,
        codigoPostal: direccionActual.codigoPostal,
        colonia: direccionActual.colonia,
        idComensal: direccionActual.idComensal,
        principal: direccionActual.id == direccionSeleccionada.id,
      );
    }
  }

  void eliminarDireccion(int idDireccion) {
    _direcciones.removeWhere(
      (direccion) => direccion.id == idDireccion,
    );

    if (_direcciones.isEmpty) {
      return;
    }

    final existePrincipal = _direcciones.any(
      (direccion) => direccion.principal,
    );

    if (!existePrincipal) {
      final primeraDireccion = _direcciones.first;

      _direcciones[0] = Direccion(
        id: primeraDireccion.id,
        alias: primeraDireccion.alias,
        calle: primeraDireccion.calle,
        numero: primeraDireccion.numero,
        codigoPostal: primeraDireccion.codigoPostal,
        colonia: primeraDireccion.colonia,
        idComensal: primeraDireccion.idComensal,
        principal: true,
      );
    }
  }
}
