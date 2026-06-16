class Alimento {
  final int id;
  final String nombre;
  final String descripcion;
  final double precio;
  final String foto;
  final int idCategoria;
  final int ranking;

  Alimento(
      {required this.id,
      required this.nombre,
      required this.descripcion,
      required this.precio,
      required this.foto,
      required this.idCategoria,
      required this.ranking});
}
