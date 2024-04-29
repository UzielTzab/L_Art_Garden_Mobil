import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/Models/user.dart';
import 'package:l_art_garden_mobil/Services/google_login.dart';
import 'package:l_art_garden_mobil/Services/service_user.dart';
import 'package:l_art_garden_mobil/model_provider/users_provider.dart';
import 'package:provider/provider.dart';
import 'main_store.dart';
import '../Widgets/waiting_load.dart';
import 'package:soundpool/soundpool.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;
  final GlobalKey<FormState> _FormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Soundpool pool = Soundpool.fromOptions(
      options: SoundpoolOptions(streamType: StreamType.music),
    );
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://i0.wp.com/ecoosfera.com/wp-content/uploads/2022/11/VYITZEZTTZALFNAA6J63F3I43E.jpg?fit=1024%2C683&ssl=1',
            fit: BoxFit.cover,
          ),
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color.fromARGB(255, 0, 0, 0), // Color más oscuro
                  Color.fromARGB(157, 0, 0, 0), // Color más oscuro
                  Color.fromARGB(
                      0, 5, 5, 5), // Transparente en la parte superior
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: heightScreen * 0.1, right: 90, left: 90),
                  child: const Text(
                    "L-Art Garden",
                    style: TextStyle(
                        fontFamily: 'Capri',
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 40,
                        letterSpacing: 4),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  child: Container(
                    height: 300,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(0, 255, 255, 255),
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 30,
                        right: 30,
                        top: heightScreen * 0.05,
                      ),
                      child: Form(
                        key: _FormKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              controller: emailController,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Por favor llena el campo';
                                }
                                // Expresión regular para validar el correo electrónico
                                Pattern pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regex = new RegExp(pattern.toString());
                                if (!regex.hasMatch(value!))
                                  return 'Ingresa un correo electrónico válido';
                                return null;
                              },
                              decoration: const InputDecoration(
                                  hintStyle: TextStyle(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                  labelStyle: TextStyle(
                                      fontFamily: 'Capri',
                                      fontSize: 15,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                  border: UnderlineInputBorder(),
                                  labelText: 'Tu correo'),
                              style: const TextStyle(
                                  color: Colors.white, fontFamily: 'Capri'),
                            ),
                            TextFormField(
                              controller: passwordController,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Por favor llena el campo';
                                }
                                if (value!.length > 8) {
                                  return 'La contraseña no puede tener más de 8 caracteres';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                    fontFamily: 'Capri',
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                                labelText: 'Tu Contraseña',
                                suffixIcon: IconButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                  icon: Icon(_obscurePassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined),
                                ),
                              ),
                              style: const TextStyle(
                                  color: Colors.white, fontFamily: 'Capri'),
                              obscureText: _obscurePassword,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all(
                                      const Size.fromWidth(220)),
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.amber),
                                ),
                                onPressed: () async {
                                  if (_FormKey.currentState?.validate() ??
                                      false) {
                                    print(
                                        'Correo electrónico: ${emailController.text}');
                                    print(
                                        'Contraseña: ${passwordController.text}');
                                    try {
                                      // Realiza la solicitud para obtener el usuario
                                      final user =
                                          await getUserByEmailAndPassword(
                                        emailController.text,
                                        passwordController.text,
                                      );

                                      // Verifica el tipo de usuario
                                      if (user.tipoUsuario == 1) {
                                        context.read<UserProvider>().setUser(
                                              UserModel(
                                                id: user.id,
                                                nombre: user.nombre,
                                                correo: user.correo,
                                                telefono: user.telefono,
                                                contrasenia: user.contrasenia,
                                                fechaNacimiento:
                                                    user.fechaNacimiento,
                                                genero: user.genero,
                                                tipoUsuario: user.tipoUsuario,
                                                foto: user.foto,
                                                latitud: user.latitud / 1,
                                                longitud: user.longitud / 1,
                                                direccion1: user.direccion1,
                                                direccion2: user.direccion2,
                                                direccion3: user.direccion3,
                                              ),
                                            );

                                        // Si la solicitud fue exitosa, muestra el mensaje con el nombre del usuario
                                        final welcomeMessage =
                                            '¡Bienvenido ${user.nombre}!';

                                        // Muestra la página de espera con el mensaje adecuado
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => WaitingPage(
                                              message: welcomeMessage,
                                              onWaitComplete: () async {
                                                int soundId = await rootBundle
                                                    .load(
                                                        "assets/sounds/lsound.mp3")
                                                    .then((ByteData soundData) {
                                                  return pool.load(soundData);
                                                });
                                                int streamId =
                                                    await pool.play(soundId);
                                                // Navega a la siguiente pantalla después de completar la espera
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MainStore(),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        );
                                      } else {
                                        // Si el tipo de usuario no es 1, muestra un modal
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title:
                                                  const Text('Cuenta no apta'),
                                              content: const Text(
                                                  'La cuenta con la que estás intentando iniciar sesión no es válida para hacer compras en la aplicación. Puedes crear una cuenta para realizar compras.'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('Aceptar'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    } catch (e) {
                                      // Maneja el error en caso de que falle la solicitud
                                      print('Esto es el error $e');
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                                'Error al iniciar sesión'),
                                            content: const Text(
                                                'Los datos de inicio de sesión proporcionados son incorrectos. Por favor, verifica y vuelve a intentarlo.'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Aceptar'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      // Puedes mostrar un diálogo o mensaje de error aquí si lo deseas
                                    }
                                  }
                                },
                                child: const Text(
                                  'Iniciar Sesión',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: heightScreen * 0.1),
                  child: Column(
                    children: [
                      const Text(
                        'o continua con',
                        style: TextStyle(color: Colors.white),
                      ),
                      ElevatedButton.icon(
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                              const Size.fromWidth(240)),
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                        ),
                        onPressed: () {
                          // Agregar funcionalidad para continuar con Facebook
                        },
                        icon: const Icon(
                          Icons.facebook,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Continuar con Facebook',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                              const Size.fromWidth(240)),
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                        ),
                        onPressed: () {
                          signInWithGoogle().then((UserModel? user) {
                            if (user != null) {
                              // Aquí puedes manejar el usuario que ha iniciado sesión
                              // Por ejemplo, puedes navegar a otra página:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainStore(),
                                ),
                              );
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.g_mobiledata,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        label: const Text(
                          'Continuar con Google',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: heightScreen * 0),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      '¿Olvidaste tu contraseña?',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.amber,
                        letterSpacing: 1,
                        decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Limpia los controladores cuando el Widget se elimina del árbol de widgets
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
