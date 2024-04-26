class DetallePedido {
  final int idDetalle;
  final double montoIngresado;
  final int cantidadPedidos;
  final double montoTotalAPagar;

  DetallePedido({
    required this.idDetalle,
    required this.montoIngresado,
    required this.cantidadPedidos,
    required this.montoTotalAPagar,
  });

  // Método para convertir un mapa en un DetallePedido
  factory DetallePedido.fromJson(Map<String, dynamic> json) {
    return DetallePedido(
      idDetalle: json['IDDetalle'],
      montoIngresado: json['MontoIngresado'],
      cantidadPedidos: json['CantidadPedidos'],
      montoTotalAPagar: json['MontoTotalAPagar'],
    );
  }

  // Método para convertir un DetallePedido en un mapa
  Map<String, dynamic> toJson() {
    return {
      'IDDetalle': idDetalle,
      'MontoIngresado': montoIngresado,
      'CantidadPedidos': cantidadPedidos,
      'MontoTotalAPagar': montoTotalAPagar,
    };
  }
}
