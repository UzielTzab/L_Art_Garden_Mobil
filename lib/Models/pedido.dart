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
  final String nombreCliente;
  final String nombreProducto;
  final int cantidadSeleccionado;
  final String direccion;
  final String imagenReferencia;

  Pedido(
      {this.idPedido,
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
      required this.nombreCliente,
      required this.nombreProducto,
      required this.cantidadSeleccionado,
      required this.direccion,
      required this.imagenReferencia});

  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
        idPedido: json['IDPedido'],
        idUsuario: json['IDUsuario'] ?? 0,
        fechaHoraPedido: json['FechaHoraPedido'] ?? '',
        pagoTotal: (json['PagoTotal'] is int)
            ? (json['PagoTotal'] as int).toDouble()
            : json['PagoTotal'] ?? 0.0,
        idEstado: json['IdEstado'] ?? 0,
        idProducto: json['IDProducto'] ?? 0,
        cantidadProducto: json['CantidadProducto'] ?? 0,
        idTarjeta: json['IDTarjeta'] ?? 0,
        precioUnitario: (json['PrecioUnitario'] is int)
            ? (json['PrecioUnitario'] as int).toDouble()
            : json['PrecioUnitario'] ?? 0.0,
        precioTotal: (json['PrecioTotal'] is int)
            ? (json['PrecioTotal'] as int).toDouble()
            : json['PrecioTotal'] ?? 0.0,
        idInventario: json['IDInventario'] ?? 0,
        idDetallePedido: json['IDDetallePedido'] ?? 0,
        fechaEntrega: json['FechaEntrega'] ?? '',
        horaEntrega: json['HoraEntrega'] ?? '',
        nombreCliente: json['NombreCliente'] ?? '',
        nombreProducto: json['NombreProducto'] ?? '',
        cantidadSeleccionado: json['CantidadSeleccionada'] ?? 0,
        direccion: json['Direccion'] ?? '',
        imagenReferencia: json['ImagenReferencia'] ?? '');
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
      'NombreCliente': nombreCliente,
      'NombreProducto': nombreProducto,
      'CantidadSeleccionada': cantidadSeleccionado,
      'Direccion': direccion,
      'ImagenReferencia': imagenReferencia
    };
  }

  @override
  String toString() {
    return 'Pedido{idPedido: $idPedido, idEstado: $idEstado, fechaHoraPedido: $fechaHoraPedido, precioUnitario: $precioUnitario, idDetallePedido: $idDetallePedido, idUsuario: $idUsuario, idProducto: $idProducto, cantidadProducto: $cantidadProducto, precioTotal: $precioTotal, idTarjeta: $idTarjeta, fechaEntrega: $fechaEntrega, horaEntrega: $horaEntrega, idInventario: $idInventario, pagoTotal: $pagoTotal, nombreCliente: $nombreCliente, nombreProducto: $nombreProducto, cantidadSeleccionado: $cantidadSeleccionado, direccion: $direccion, imagenReferencia: $imagenReferencia}';
  }
}
