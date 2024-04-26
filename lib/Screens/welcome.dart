import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/Models/user.dart';
import 'package:l_art_garden_mobil/Screens/login_screen.dart';
import 'package:l_art_garden_mobil/Screens/register.dart';
import 'package:l_art_garden_mobil/Widgets/waiting_load.dart';
import 'package:provider/provider.dart';
import 'main_store.dart';
import 'package:soundpool/soundpool.dart';
import 'package:flutter/services.dart';
import '../model_provider/users_provider.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  double opacityLevel = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        opacityLevel = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Soundpool pool = Soundpool.fromOptions(
      options: SoundpoolOptions(streamType: StreamType.music),
    );
    double heightScreen = MediaQuery.of(context).size.width;
    print(heightScreen / 4);
    return Scaffold(
      body: AnimatedOpacity(
        opacity: opacityLevel,
        duration: Duration(seconds: 2),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            //IMAGEN DE FONDO
            Image.asset(
              'assets/images/yellow_flowers_edited.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            // CONTENEDOR QUE TIENE COLORES DEGRADADOS DE OSCURO A TRANSPARENTE
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color.fromARGB(240, 0, 0, 0),
                    Color.fromARGB(
                        0, 73, 73, 73), // Transparente en la parte superior
                  ],
                ),
              ),
            ),
            //TITULO
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1),
              child: GestureDetector(
                child: const Text(
                  'L-Art Garden',
                  style: TextStyle(
                    fontFamily: 'Arial',
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            //BOTON DE INICIAR SESION
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.83,
              ),
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 50.0)),
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 241, 185, 65)),
                  elevation: MaterialStateProperty.resolveWith(
                      (states) => 0), // Establecer la elevación a cero
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          LoginScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = Offset(1.0, 0.0);
                        var end = Offset.zero;
                        var tween = Tween(begin: begin, end: end);
                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                icon: Image(
                    width: MediaQuery.of(context).size.width * .1,
                    height: MediaQuery.of(context).size.height * .05,
                    image: AssetImage(
                        "assets/images/icons/Logo L_Art_Garden_white.png")),
                label: const Text("Iniciar sesión",
                    style: TextStyle(fontFamily: 'Arial', color: Colors.white)),
              ),
            ),
            //LINK AL FORMULARIO DE REGISTRO DE UNA NUEVA CUENTA
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.91),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "¿No tienes cuenta?",
                    style: TextStyle(
                        fontFamily: 'Capri',
                        color: Colors.amber,
                        fontSize: 15,
                        letterSpacing: 2),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  registerScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            var begin = Offset(0.0, -1.0);
                            var end = Offset.zero;
                            var tween = Tween(begin: begin, end: end);
                            var offsetAnimation = animation.drive(tween);

                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: const Text(
                      "Crear",
                      style: TextStyle(
                          fontFamily: 'Capri',
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.amber,
                          color: Colors.amber,
                          fontSize: 15,
                          letterSpacing: 2),
                    ),
                  ),
                ],
              ),
            ),
            //LINK DE ENTRADA COMO INVITADO
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.95),
              child: GestureDetector(
                onTap: () async {
                  int soundId = await rootBundle
                      .load("assets/sounds/lsound.mp3")
                      .then((ByteData soundData) {
                    return pool.load(soundData);
                  });
                  int streamId = await pool.play(soundId);
                  context.read<UserProvider>().setUser(
                        UserModel(
                          id: 0,
                          nombre: "",
                          correo: "",
                          telefono: "",
                          contrasenia: "",
                          fechaNacimiento: "",
                          genero: "",
                          tipoUsuario: 0,
                          foto: "",
                          latitud: 0,
                          longitud: 0,
                          direccion1: "",
                          direccion2: "",
                          direccion3: "",
                        ),
                      );

                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WaitingPage(
                        message: '¡Hola amante de las flores!',
                        onWaitComplete: () async {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const MainStore(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                var begin = Offset(-1.0, 0.0);
                                var end = Offset.zero;
                                var tween = Tween(begin: begin, end: end);
                                var offsetAnimation = animation.drive(tween);

                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Entrar como invitado",
                  style: TextStyle(
                      fontFamily: 'Capri',
                      decoration: TextDecoration.underline,
                      decorationColor: Color.fromARGB(255, 210, 66, 169),
                      color: Color.fromARGB(255, 238, 87, 195),
                      fontSize: 15,
                      letterSpacing: 2),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
