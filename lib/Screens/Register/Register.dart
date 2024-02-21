import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/Models/user.dart';
import 'package:l_art_garden_mobil/Services/service.dart';
import '../LoginScreen/loginScreen.dart';
import '../../Widgets/waitingLoad.dart';
import 'package:intl/intl.dart';

class registerScreen extends StatefulWidget {
  const registerScreen({super.key});

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  String nombre = '';
  String apellido = '';
  String correro = '';
  String contrasenia = '';
  String confirmarContrasenia = '';

  bool pass = false;
  bool confirmPass = false;
  DateTime _selectedDay = DateTime.now();
  final GlobalKey<FormState> _FormKey = GlobalKey<FormState>();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _Name = TextEditingController();
  TextEditingController _Email = TextEditingController();
  TextEditingController _PasswordInfo = TextEditingController();
  TextEditingController _PasswordImfoConfirm = TextEditingController();
  TextEditingController _Telefono = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String _selectItem = "M";
    List<String> _items = ["M", "F"];
    return Placeholder(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: Image.network(
                'https://i0.wp.com/ecoosfera.com/wp-content/uploads/2022/11/VYITZEZTTZALFNAA6J63F3I43E.jpg?fit=1024%2C683&ssl=1',
                fit: BoxFit.cover,
              ),
            ),
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black87, // Color más oscuro
                    Colors.transparent, // Transparente en la parte superior
                  ],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: Container(
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 90, right: 90, left: 90),
                    child: Text(
                      "L-Art Garden",
                      style: TextStyle(
                          fontFamily: 'Capri',
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 45,
                          letterSpacing: 4),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 60, top: 10, left: 20, right: 20),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      child: Form(
                        key: _FormKey,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 10, bottom: 10),
                          child: Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 6),
                                      child: Text(
                                        'Bienvenido a',
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: Color.fromARGB(
                                                255, 169, 169, 169)),
                                      ),
                                    ),
                                    const Text("L-Art Garden",
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: Color.fromARGB(
                                                255, 169, 169, 169))),
                                    TextFormField(
                                      controller: _Name,
                                      onChanged: (value) {
                                        setState(() {
                                          nombre = value;
                                        });
                                      },
                                      decoration: const InputDecoration(
                                          labelStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 150, 150, 150)),
                                          border: UnderlineInputBorder(),
                                          labelText: 'Nombre'),
                                      validator: (value) {
                                        if (value?.isEmpty ?? true) {
                                          return 'Porfavor complete el campo';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      controller: _Email,
                                      onChanged: (value) {
                                        setState(() {
                                          correro = value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value?.isEmpty ?? true) {
                                          return 'Complete el campo';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          labelStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 150, 150, 150)),
                                          border: UnderlineInputBorder(),
                                          labelText: 'Correo electronico'),
                                    ),
                                    TextFormField(
                                      onChanged: (value) {
                                        setState(() {
                                          contrasenia = value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value?.isEmpty ?? true) {
                                          return 'Completa el campo';
                                        }
                                        return null;
                                      },
                                      controller: _Telefono,
                                      obscureText: pass,
                                      decoration: const InputDecoration(
                                          labelStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 150, 150, 150)),
                                          border: UnderlineInputBorder(),
                                          labelText: 'Telefono'),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 18.0),
                                      child: Text("Año de nacimiento",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Color.fromARGB(
                                                  255, 169, 169, 169))),
                                    ),
                                    TextFormField(
                                      controller: _dateController,
                                      decoration: const InputDecoration(
                                        labelText: 'Seleccione una fecha',
                                        suffixIcon: Icon(Icons.calendar_today),
                                      ),
                                      onTap: () async {
                                        final DateTime? pickedDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: _selectedDay,
                                          firstDate: DateTime.utc(1920, 1, 1),
                                          lastDate: DateTime.now(),
                                        );
                                        if (pickedDate != null) {
                                          setState(() {
                                            _selectedDay = pickedDate;
                                            _dateController.text =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(pickedDate);
                                          });
                                        }
                                      },
                                    ),
                                    TextFormField(
                                      onChanged: (value) {
                                        setState(() {
                                          contrasenia = value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value?.isEmpty ?? true) {
                                          return 'Completa el campo';
                                        }
                                        return null;
                                      },
                                      controller: _PasswordInfo,
                                      obscureText: pass,
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                pass = !pass;
                                                print(pass);
                                              });
                                            },
                                            icon: Icon(pass
                                                ? Icons.visibility_off_outlined
                                                : Icons.visibility_outlined),
                                          ),
                                          labelStyle: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 150, 150, 150)),
                                          border: const UnderlineInputBorder(),
                                          labelText: 'Contraseña'),
                                    ),
                                    TextFormField(
                                      onChanged: (value) {
                                        setState(() {
                                          confirmarContrasenia = value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value?.isEmpty ?? true) {
                                          return "Completa el campo";
                                        }
                                        return null;
                                      },
                                      controller: _PasswordImfoConfirm,
                                      obscureText: confirmPass,
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  confirmPass = !confirmPass;
                                                  print(
                                                      "Presiono la vista del input confirmar confirmar contraseña");
                                                });
                                              },
                                              icon: Icon(confirmPass
                                                  ? Icons
                                                      .visibility_off_outlined
                                                  : Icons.visibility_outlined)),
                                          labelStyle: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 150, 150, 150)),
                                          border: const UnderlineInputBorder(),
                                          labelText: ' Confirmar Contraseña'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30.0),
                                      child: DropdownButtonFormField<String>(
                                        value: _selectItem,
                                        items: _items.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            _selectItem = newValue!;
                                          });
                                        },
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 12.0),
                                          labelText: 'Seleciona tu genero',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.amber),
                                            elevation:
                                                MaterialStateProperty.all(0)),
                                        onPressed: () {
                                          if (_FormKey.currentState
                                                  ?.validate() ??
                                              false) {
                                            // Validación de la confirmación de la contraseña
                                            if (_PasswordInfo.text !=
                                                _PasswordImfoConfirm.text) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Las contraseñas no coinciden'),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                              return; // Detener el proceso si las contraseñas no coinciden
                                            }

                                            User newUser = User(
                                              id: 0,
                                              nombre: _Name.text,
                                              telefono: _Telefono.text,
                                              correo: _Email.text,
                                              contrasena: _PasswordInfo.text,
                                              fechaNacimiento:
                                                  _dateController.text,
                                              genero: _selectItem,
                                            );

                                            // Enviar la solicitud POST para crear el usuario
                                            createUser(newUser);

                                            const welcome =
                                                '¡Estamos creando tu cuenta! Redirigiendo a la pagina de INICIO';

                                            // Resto del código para la navegación
                                            print(
                                                'nombre: ${newUser.nombre}, telefono: ${newUser.telefono}');
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    WaitingPage(
                                                  message: welcome,
                                                  onWaitComplete: () {
                                                    // Navega a la siguiente pantalla después de completar la espera
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const LoginScreen(),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        child: const Text(
                                          "Crear cuenta",
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      child: const Text(
                        "¿Ya tienes una cuenta?",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.amber,
                            letterSpacing: 1,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.amber),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
