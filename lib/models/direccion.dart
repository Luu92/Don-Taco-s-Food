class Direccion {
  final int id;

  final String alias;

  final String calle;

  final String numero;

  final String codigoPostal;

  final String colonia;

  final String referencia;

  final int idComensal;
  final bool principal;

  Direccion(
      {required this.id,
      required this.alias,
      required this.calle,
      required this.numero,
      required this.codigoPostal,
      required this.colonia,
      required this.referencia,
      required this.idComensal,
      required this.principal});
}
