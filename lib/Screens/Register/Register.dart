import 'package:flutter/material.dart';
import '../Home/Main_Store/Main_Store.dart';
import '../LoginScreen/loginScreen.dart';

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
  final GlobalKey<FormState> _FormKey = GlobalKey<FormState>();
  TextEditingController _Name = TextEditingController();
  TextEditingController _LastName = TextEditingController();
  TextEditingController _Email = TextEditingController();
  TextEditingController _PasswordInfo = TextEditingController();
  TextEditingController _PasswordImfoConfirm = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                                      onChanged: (value) {
                                        setState(() {
                                          apellido = value;
                                        });
                                      },
                                      decoration: const InputDecoration(
                                          labelStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 150, 150, 150)),
                                          border: UnderlineInputBorder(),
                                          labelText: 'Apellido'),
                                      validator: (value) {
                                        if (value?.isEmpty ?? true) {
                                          return 'Porfavor complete el campo';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormField(
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
                                          labelText:
                                              'Correo o numero de telefono'),
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
                                      padding: const EdgeInsets.only(top: 30),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            fixedSize:
                                                const MaterialStatePropertyAll(
                                                    Size(220, 30)),
                                            elevation:
                                                MaterialStateProperty.all(0),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.amber)),
                                        onPressed: () {
                                          if (_FormKey.currentState
                                                  ?.validate() ??
                                              false) {
                                            print(
                                                'nombre: $nombre, apellido: $apellido');
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LoginScreen()));
                                          }
                                        },
                                        child: const Text(
                                          "Crear cuenta",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
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
