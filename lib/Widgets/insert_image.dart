import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageSelector extends StatefulWidget {
  @override
  _ImageSelectorState createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  File? _image;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  // Método para obtener la ruta del archivo de imagen seleccionado
  String? getImagePath() {
    return _image?.path;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: _image == null
              ? Text('Ninguna imagen cargada.')
              : Image.file(_image!),
        ),
        ElevatedButton(
          style: ButtonStyle(elevation: MaterialStateProperty.all(0)),
          onPressed: _getImage,
          child: Text('Agregar foto de perfil'),
        ),
      ],
    );
  }
}
