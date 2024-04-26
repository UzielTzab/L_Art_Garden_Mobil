class Pedido {
  final int? idPedido;
  final int idUsuario;
  final String fechaHoraPedido;
  final double pagoTotal;
  final int idEstado;
  final int idProducto;
  final int cantidadProducto;
  final int idTarjeta;
  final double precioUnitario;
  final double precioTotal;
  final int idInventario;
  final int idDetallePedido;
  final String fechaEntrega;
  final String horaEntrega;

  Pedido({
    this.idPedido,
    required this.idUsuario,
    required this.fechaHoraPedido,
    required this.pagoTotal,
    required this.idEstado,
    required this.idProducto,
    required this.cantidadProducto,
    required this.idTarjeta,
    required this.precioUnitario,
    required this.precioTotal,
    required this.idInventario,
    required this.idDetallePedido,
    required this.fechaEntrega,
    required this.horaEntrega,
  });

  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
      idPedido: json['IDPedido'],
      idUsuario: json['IDUsuario'],
      fechaHoraPedido: json['FechaHoraPedido'],
      pagoTotal: json['PagoTotal'],
      idEstado: json['IdEstado'],
      idProducto: json['IDProducto'],
      cantidadProducto: json['CantidadProducto'],
      idTarjeta: json['IDTarjeta'],
      precioUnitario: json['PrecioUnitario'],
      precioTotal: json['PrecioTotal'],
      idInventario: json['IDInventario'],
      idDetallePedido: json['IDDetallePedido'],
      fechaEntrega: json['FechaEntrega'],
      horaEntrega: json['HoraEntrega'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'IDPedido': idPedido,
      'IDUsuario': idUsuario,
      'FechaHoraPedido': fechaHoraPedido,
      'PagoTotal': pagoTotal,
      'IdEstado': idEstado,
      'IDProducto': idProducto,
      'CantidadProducto': cantidadProducto,
      'IDTarjeta': idTarjeta,
      'PrecioUnitario': precioUnitario,
      'PrecioTotal': precioTotal,
      'IDInventario': idInventario,
      'IDDetallePedido': idDetallePedido,
      'FechaEntrega': fechaEntrega,
      'HoraEntrega': horaEntrega,
    };
  }

  @override
  String toString() {
    return 'Pedido{idPedido: $idPedido, idEstado: $idEstado, fechaHoraPedido: $fechaHoraPedido, precioUnitario: $precioUnitario, idDetallePedido: $idDetallePedido, idUsuario: $idUsuario, idProducto: $idProducto, cantidadProducto: $cantidadProducto, precioTotal: $precioTotal, idTarjeta: $idTarjeta, fechaEntrega: $fechaEntrega, horaEntrega: $horaEntrega, idInventario: $idInventario, pagoTotal: $pagoTotal}';
  }
}
