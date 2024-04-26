import 'package:intl/intl.dart';

String getShopStatus(String horaApertura, String horaCierre) {
  DateTime now = DateTime.now();
  DateFormat format = DateFormat("HH:mm:ss");

  DateTime startTime = format.parse(horaApertura);
  DateTime endTime = format.parse(horaCierre);

  // Ajustar las fechas de inicio y fin para que sean en el día actual
  startTime = DateTime(now.year, now.month, now.day, startTime.hour,
      startTime.minute, startTime.second);
  endTime = DateTime(now.year, now.month, now.day, endTime.hour, endTime.minute,
      endTime.second);

  if (now.isAfter(startTime) && now.isBefore(endTime)) {
    return 'Abierto';
  } else {
    return 'Cerrado';
  }
}
