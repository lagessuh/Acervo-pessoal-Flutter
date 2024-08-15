import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//para armazenar imagens da câmera
File? _photo;
//Dependência que permite importar imagem da câmera ou galeria
final ImagePicker _imagePicker = ImagePicker();
//para armazenar imagens da galeria para ser utilizar no browser
Uint8List? webImage = Uint8List(8);

Future _openDialog(BuildContext context) => showDialog(
    context: context, //-- mude aqui
    builder: (context) => StatefulBuilder(
        //-- mude aqui
        builder: (context, setState) => AlertDialog(
              //-- mude aqui
              surfaceTintColor: Colors.white,
              title: const Text('Dados do Viajante'),
              content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Container(
                    height: 600,
                    width: 500,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _displayPicker(context, setState);

                            ///mude aqui
                          },
                          child: _photo != null
                              ? ClipRRect(
                                  child: kIsWeb
                                      ? Image.memory(
                                          webImage!,
                                          height: 100,
                                        )
                                      : Image.file(
                                          _photo!,
                                          height: 100,
                                        ),
                                )
                              : Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  width: 100,
                                  height: 100,
                                  child: const Icon(
                                    Icons.camera_alt_outlined,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  );
                },
              ),
            )));

imageGallery(StateSetter setState) async {
  //-- mude aqui
  final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
  File? image; //imagem obtida da câmera ou tablet
  Uint8List imgWeb = Uint8List(8); //imagem obtida via browser
  if (!kIsWeb) {
    if (pickedFile != null) {
      image = File(pickedFile.path);
    } else {
      debugPrint('Imagem não selecionada (mobile)');
    }
  } else {
    if (pickedFile != null) {
      imgWeb = await pickedFile.readAsBytes();
      image = File(pickedFile.path);
    }
  }
  setState(() {
    if (!kIsWeb) {
      _photo = image;
    } else {
      webImage = imgWeb;
      _photo = image;
    }
  });
  return _photo;
}

void _displayPicker(BuildContext context, StateSetter setState) {
  //-- mude aqui
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Wrap(
        children: [
          ListTile(
            onTap: () {
              imageGallery(setState); //-- mude aqui
              Navigator.of(context).pop();
            },
            leading: Icon(Icons.photo_library),
            title: const Text(
              'Galeria',
              style: TextStyle(
                color: Color.fromARGB(255, 1, 17, 1),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.photo_camera),
            title: Text(
              'Câmera',
              style: TextStyle(
                color: Color.fromARGB(255, 1, 17, 1),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      );
    },
  );
}

Future imgFromGallery(StateSetter setState) async {
  final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);

  setState(() {
    if (pickedFile != null) {
      _photo = File(pickedFile.path);
      // uploadFile();
    } else {
      print('No image selected.');
    }
  });
}

Future imgFromCamera(StateSetter setState) async {
  final pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);

  setState(() {
    if (pickedFile != null) {
      _photo = File(pickedFile.path);
      // uploadFile();
    } else {
      print('No image selected.');
    }
  });
}
