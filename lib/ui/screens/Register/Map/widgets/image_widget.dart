import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:path/path.dart' as path;

class ImageWidget extends StatefulWidget {
  const ImageWidget({Key? key, required this.selectImage}) : super(key: key);

  final Function selectImage;

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  File? _image;

  Future<void> _openCamera() async {
    var imagePicker = ImagePicker();
    final file =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 650);

    if (file == null) return;

    setState(() {
      _image = File(file.path);
    });

    final directory = await pathProvider.getApplicationDocumentsDirectory();
    final fileName = path.basename(_image!.path);
    final resultDirectory = await _image!.copy("${directory.path}/$fileName");
    widget.selectImage(resultDirectory);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
            onPressed: _openCamera,
            icon: const Icon(Icons.camera),
            label: const Text(
              "تصویر فروشگاه",
              style: TextStyle(fontFamily: 'IransansDn'),
            ),
          ),
          Container(
            height: 125,
            width: 125,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              // border: Border.all(width: 1, color: Colors.grey),
            ),
            child: _image == null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset('assets/images/rm373batch12-016.jpg'),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      _image!,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
