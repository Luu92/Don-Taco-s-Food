import '../models/direccion.dart';

class DireccionService {
  final List<Direccion> _direcciones = [
    Direccion(
        id: 1,
        alias: "Casa",
        calle: "Manuel Cañas",
        numero: "Mz 105 Lt 25",
        codigoPostal: "09750",
        colonia: "Des Urb Quetzalcoatl",
        idComensal: 1,
        principal: false),
    Direccion(
        id: 2,
        alias: "Oficina",
        calle: "Lopez Portillo",
        numero: "1300",
        codigoPostal: "13500",
        colonia: "La Polvorilla",
        idComensal: 1,
        principal: false),
  ];

  List<Direccion> obtenerDirecciones() {
    return _direcciones;
  }

  void agregarDireccion(Direccion direccion) {
    _direcciones.add(direccion);
  }

  void editarDireccion(Direccion direccion) {
    final index = _direcciones.indexWhere(
      (d) => d.id == direccion.id,
    );

    if (index != -1) {
      _direcciones[index] = direccion;
    }
  }
}
