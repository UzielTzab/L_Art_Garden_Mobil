import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Notificaciones'),
      ),
      body: ListView.builder(
          itemCount: 2, // Número de notificaciones
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color.fromARGB(
                    255, 243, 166, 33), // Color de fondo del avatar
                child: Icon(Icons.notifications), // Icono de notificación
                foregroundColor: Colors.white, // Color del icono
              ),
              title: const Text(
                'Compra confirmada ', // Título de la notificación
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        Color.fromARGB(255, 193, 154, 105) // Texto en negrita
                    ),
              ),
              subtitle: const Text(
                'Tu compra fue confirmada y esta en preparcion de envio',
                style: TextStyle(
                    color: Color.fromARGB(
                        255, 131, 131, 131)), // Descripción de la notificación
              ),
              onTap: () {
                // Acción al hacer tap en la notificación
                print('Notificación $index pulsada');
              },
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Color.fromARGB(255, 163, 139, 68),
                ), // Icono de eliminar
                onPressed: () {
                  // Acción al pulsar en el icono de eliminar
                  print('Eliminar notificación $index');
                },
              ),
            );
          }),
    );
  }
}
