import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/Models/user.dart';

class CompleteProfilePage extends StatefulWidget {
  final UserModel user;

  CompleteProfilePage({required this.user});

  @override
  _CompleteProfilePageState createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String? telefono;
  String? contrasenia;
  String? fechaNacimiento;
  String? genero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Complete Profile')),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Telefono'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
              onSaved: (value) {
                telefono = value;
              },
            ),
            // Agrega más campos aquí...
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  // Actualiza el usuario con la nueva información
                  widget.user.telefono = telefono ?? '';
                  // Actualiza los demás campos...

                  // Navega a la siguiente página...
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
