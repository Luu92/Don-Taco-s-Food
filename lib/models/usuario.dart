class Usuario {
  final int id;
  final String nombre;
  final String correo;
  final String telefono;

  Usuario(
      {required this.id,
      required this.nombre,
      required this.correo,
      required this.telefono});

  Usuario copyWith(
      {int? id, String? nombre, String? correo, String? telefono}) {
    return Usuario(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        correo: correo ?? this.correo,
        telefono: telefono ?? this.telefono);
  }
}
