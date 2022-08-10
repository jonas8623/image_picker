import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  File? _file;
  final _imagePicker = ImagePicker();
  
  Widget _aspectRadio({required Widget widget}) =>
      AspectRatio(aspectRatio: 1.5, child: widget);

  Widget _elevatedButton({required GestureTapCallback onPressed,required String text}) {
    return ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(4.0),
          padding: MaterialStateProperty.all(EdgeInsets.only(top: 12.0, bottom: 12.0)),
          fixedSize: MaterialStateProperty.all(Size(300, 50))
        ),
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold),)
    );
  }

  Widget _sizedBox(double height) => SizedBox(height: height,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Imagem'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _file == null
              ? _aspectRadio(
                  widget: Container(
                      color: Colors.grey[200],
                      child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(Icons.image, size: 40.0,),
                                _sizedBox(8.0),
                                const Text('Não há imagem selecionada')
                              ],)))
              : _aspectRadio(widget: Image.file(File(_file!.path), fit: BoxFit.cover,)),
          _sizedBox(18.0),
          _elevatedButton(onPressed: () async => _pickImageCamera(), text: 'Tirar Foto'),
          _sizedBox(18.0),
          _elevatedButton(onPressed: () async => _pickImageGallery(), text: 'Galeria'),
        ],
      ),
    );
  }

  _pickImageCamera() async {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _file = File(image.path);
      });
    }
  }

  _pickImageGallery() async {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _file = File(image.path);
      });
    }
  }
}
