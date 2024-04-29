import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/Screens/main_store.dart';
import 'package:l_art_garden_mobil/model_provider/cartListProvider.dart';
import 'package:l_art_garden_mobil/model_provider/counter_cart.dart';
import 'package:provider/provider.dart';
import '../Widgets/waiting_load_fill.dart';

class PaymentFormScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  static const Color orangeColor = const Color.fromARGB(255, 209, 137, 49);
  static const Color baseColor = Color.fromARGB(255, 242, 173, 83);
  static const Color baseColorDark = Color.fromARGB(255, 163, 114, 49);
  static const Color unselectColor = Color.fromARGB(255, 107, 77, 12);
  static const Color disableColor = Color.fromARGB(255, 193, 193, 193);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: baseColor,
        title: Text('Formulario de Pago'),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nombre en la tarjeta',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el nombre en la tarjeta';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Número de la tarjeta',
                    prefixIcon: Icon(Icons.credit_card),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el número de la tarjeta';
                    }
                    if (!RegExp(r"^\d{16}$").hasMatch(value)) {
                      return 'Por favor ingrese un número de tarjeta válido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Fecha de vencimiento (MM/AA)',
                    prefixIcon: Icon(Icons.date_range),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la fecha de vencimiento';
                    }
                    if (!RegExp(r"^(0[1-9]|1[0-2])\/?([0-9]{2})$")
                        .hasMatch(value)) {
                      return 'Por favor ingrese una fecha de vencimiento válida';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Código de seguridad (CVV)',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el código de seguridad';
                    }
                    if (!RegExp(r"^\d{3}$").hasMatch(value)) {
                      return 'Por favor ingrese un código de seguridad válido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextButton(
                  style: TextButton.styleFrom(
                    side: BorderSide(color: Colors.black),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Obtén una referencia a tus proveedores
                      var cartListProvider =
                          Provider.of<CartListProvider>(context, listen: false);
                      var counterCartProvider =
                          Provider.of<CounterCartProvider>(context,
                              listen: false);

                      // Limpia el carrito y establece el contador a cero
                      cartListProvider.clearCart();
                      counterCartProvider.setDataCounter(counter: 0);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WaitingPage(
                            message: 'Procesando pago...',
                            onWaitComplete: () {
                              // Muestra un SnackBar con un mensaje de éxito
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: [
                                      Icon(Icons.check_circle,
                                          color: Colors.green),
                                      Text('La transacción fue un éxito'),
                                    ],
                                  ),
                                  duration: Duration(seconds: 2),
                                ),
                              );

                              // Navega a la pantalla MainScreen
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainStore()),
                              );
                            },
                          ),
                        ),
                      );
                    }
                  },
                  child: Text('Confirmar Pago'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
