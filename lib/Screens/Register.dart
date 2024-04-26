import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/Models/user.dart';
import 'package:l_art_garden_mobil/Services/service_user.dart';
import 'package:l_art_garden_mobil/Utils/data_formatter.dart';
import 'login_screen.dart';
import 'dart:convert';
import 'dart:io';
import '../Widgets/waiting_load.dart';
import 'package:intl/intl.dart';
import 'package:image/image.dart' as img;
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

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
  File? foto = null;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      File imageFile = File(pickedImage.path);
      setState(() {
        foto = imageFile;
      });
    } else {
      print('No image selected.');
    }
  }

  bool pass = true;
  bool confirmPass = true;
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
    String _selectItem = "Masculino";
    List<String> _items = ["Masculino", "Femenino"];
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
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 20, top: 20, left: 20, right: 20),
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
                                      maxLength: 20,
                                      controller: _Name,
                                      onChanged: (value) {
                                        setState(() {
                                          nombre = value;
                                        });
                                      },
                                      decoration: const InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.person,
                                            color: Color.fromARGB(
                                                255, 151, 151, 151),
                                          ),
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
                                      maxLength: 30,
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
                                          prefixIcon: Icon(
                                            Icons.email,
                                            color: Color.fromARGB(
                                                255, 151, 151, 151),
                                          ),
                                          labelStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 150, 150, 150)),
                                          border: UnderlineInputBorder(),
                                          labelText: 'Correo electronico'),
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      maxLength: 10,
                                      onChanged: (value) {
                                        setState(() {
                                          contrasenia = value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value?.isEmpty ?? true) {
                                          return 'Completa el campo';
                                        }
                                        // Añade esta validación
                                        if (value!.length != 10) {
                                          return 'El teléfono debe contener exactamente 10 dígitos';
                                        }
                                        return null;
                                      },
                                      controller: _Telefono,
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.phone,
                                          color: Color.fromARGB(
                                              255, 151, 151, 151),
                                        ),
                                        labelStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 150, 150, 150)),
                                        border: UnderlineInputBorder(),
                                        labelText: 'Telefono',
                                      ),
                                    ),
                                    TextFormField(
                                      maxLength: 10,
                                      controller: _dateController,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.date_range,
                                          color: Color.fromARGB(
                                              255, 151, 151, 151),
                                        ),
                                        labelText: 'Fecha de nacimiento',
                                        labelStyle: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 152, 151, 151)),
                                        hintText: '2022-12-31',
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400]),
                                      ),
                                      keyboardType: TextInputType.datetime,
                                      inputFormatters: [
                                        DateTextInputFormatter()
                                      ],
                                      validator: (value) {
                                        if (value?.isEmpty ?? true) {
                                          return 'Por favor complete el campo';
                                        }
                                        // Verifica que el valor tenga exactamente 10 caracteres
                                        if (value!.length != 10) {
                                          return 'La fecha debe contener exactamente 10 caracteres';
                                        }
                                        // Verifica que el valor sea una fecha válida
                                        try {
                                          DateTime inputDate =
                                              DateTime.parse(value);
                                          if (inputDate
                                              .isAfter(DateTime.now())) {
                                            return 'La fecha no puede ser posterior a la fecha actual';
                                          }
                                        } catch (e) {
                                          return 'Por favor ingrese una fecha válida';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      maxLength: 8,
                                      onChanged: (value) {
                                        setState(() {
                                          contrasenia = value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Completa el campo';
                                        } else if (value.length != 8) {
                                          return 'La contraseña debe tener exactamente 8 caracteres';
                                        }
                                        return null;
                                      },
                                      controller: _PasswordInfo,
                                      obscureText: pass,
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.password,
                                            color: Color.fromARGB(
                                                255, 151, 151, 151),
                                          ),
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
                                      maxLength: 8,
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
                                          prefixIcon: Icon(
                                            Icons.password_outlined,
                                            color: Color.fromARGB(
                                                255, 151, 151, 151),
                                          ),
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
                                          prefixIcon: Icon(
                                            Icons.people,
                                            color: Color.fromARGB(
                                                255, 151, 151, 151),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 12.0),
                                          labelText: 'Seleciona tu genero',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 16.0),
                                          child: foto == null
                                              ? const Text(
                                                  'Agrega una foto de perfil (opcional).')
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0), // Puedes ajustar el radio según tus necesidades
                                                  child: Image.file(
                                                    foto!,
                                                    width:
                                                        200, // Puedes ajustar el tamaño de la imagen aquí
                                                    height:
                                                        200, // Puedes ajustar el tamaño de la imagen aquí
                                                    fit: BoxFit
                                                        .cover, // Esto asegurará que la imagen se ajuste al tamaño del ClipRRect
                                                  ),
                                                ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton.outlined(
                                              icon: const Icon(Icons
                                                  .camera_alt), // Icono de la cámara
                                              onPressed: () async {
                                                final pickedFile =
                                                    await ImagePicker()
                                                        .pickImage(
                                                  source: ImageSource.camera,
                                                );
                                                if (pickedFile != null) {
                                                  setState(() {
                                                    foto =
                                                        File(pickedFile.path);
                                                  });
                                                }
                                              },
                                            ),
                                            IconButton.outlined(
                                              icon: const Icon(Icons
                                                  .photo_library), // Icono de la biblioteca de fotos
                                              onPressed: _getImage,
                                            ),
                                          ],
                                        ),
                                      ],
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
                                        onPressed: () async {
                                          if (_FormKey.currentState
                                                  ?.validate() ??
                                              false) {
// Lee el archivo de imagen

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

                                            UserModel newUser = UserModel(
                                              id: 0,
                                              nombre: _Name.text,
                                              telefono: _Telefono.text,
                                              correo: _Email.text,
                                              contrasenia: _PasswordInfo.text,
                                              fechaNacimiento:
                                                  _dateController.text,
                                              genero: _selectItem,
                                              tipoUsuario: 1,
                                              foto: foto?.path,
                                              latitud: 0,
                                              longitud: 0,
                                              direccion1: '',
                                              direccion2: '',
                                              direccion3: '',
                                            );

                                            // Enviar la solicitud POST para crear el usuario
                                            createUser(newUser);

                                            const welcome =
                                                '¡Estamos creando tu cuenta! Bienvenido a la plataforma L_Art Garden';

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
                                    ),
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

  Future<String> convertirFileABase64(File file) async {
    List<int> bytes = await file.readAsBytes();
    String base64Image = base64Encode(bytes);
    return base64Image;
  }
}
