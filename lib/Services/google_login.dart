import 'package:google_sign_in/google_sign_in.dart';
import 'package:l_art_garden_mobil/Models/user.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

Future<UserModel?> signInWithGoogle() async {
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;

  // Aquí puedes usar googleSignInAuthentication para crear una sesión de usuario
  // Por ejemplo, puedes enviar el token de acceso a tu servidor para autenticar al usuario

  // Devuelve un usuario
  return UserModel(
    id: int.parse(googleSignInAccount.id!),
    nombre: googleSignInAccount.displayName ?? '',
    correo: googleSignInAccount.email,
    telefono:
        '', // Valor predeterminado porque Google no proporciona un teléfono
    contrasenia:
        '', // Valor predeterminado porque Google no proporciona una contraseña
    fechaNacimiento:
        '', // Valor predeterminado porque Google no proporciona una fecha de nacimiento
    genero: '', // Valor predeterminado porque Google no proporciona un género
    tipoUsuario:
        0, // Valor predeterminado porque Google no proporciona un tipo de usuario
    foto: googleSignInAccount.photoUrl,
    latitud: 0, // Valor predeterminado porque Google no proporciona una latitud
    longitud:
        0, // Valor predeterminado porque Google no proporciona una longitud
    direccion1:
        '', // Valor predeterminado porque Google no proporciona una dirección
    direccion2: '',
    direccion3: '',
  );
}
