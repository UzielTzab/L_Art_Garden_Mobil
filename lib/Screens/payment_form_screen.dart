import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/Screens/main_store.dart';
import 'package:l_art_garden_mobil/model_provider/cartListProvider.dart';
import 'package:l_art_garden_mobil/model_provider/counter_cart.dart';
import 'package:provider/provider.dart';
import '../Widgets/waiting_load_fill.dart';

class PaymentFormScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el número de la tarjeta';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Fecha de vencimiento (MM/AA)',
                    prefixIcon: Icon(Icons.date_range),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la fecha de vencimiento';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Código de seguridad (CVV)',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el código de seguridad';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    side: MaterialStateProperty.all(
                        BorderSide(color: Colors.black)),
                    foregroundColor: MaterialStateProperty.all(Colors.black),
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
