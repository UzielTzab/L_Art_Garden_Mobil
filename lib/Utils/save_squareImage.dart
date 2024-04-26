import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

Future<void> saveImage(File imageFile) async {
  // Lee el archivo de imagen
  Uint8List bytes = await imageFile.readAsBytes();

  // Decodifica la imagen
  img.Image image = img.decodeImage(bytes)!;

  // Redimensiona la imagen a un tamaño cuadrado (por ejemplo, 200x200)
  img.Image resizedImage = img.copyResize(image, width: 200, height: 200);

  // Codifica la imagen de nuevo en formato JPEG con cierta calidad (por ejemplo, 80)
  List<int> resizedBytes = img.encodeJpg(resizedImage, quality: 80);

  // Guarda la imagen en un nuevo archivo
  File newImageFile = File('${imageFile.path}_resized.jpg');
  await newImageFile.writeAsBytes(resizedBytes);

  // Ahora puedes guardar newImageFile.path en tu base de datos
}
