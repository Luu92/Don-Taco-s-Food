class Pedido {
  final int id;
  final DateTime fecha;
  final String estado;
  final double total;
  final String comentario;
  final List<Map<String, dynamic>> alimentos;

  Pedido({
    required this.id,
    required this.fecha,
    required this.estado,
    required this.total,
    required this.comentario,
    required this.alimentos,
  });
}
