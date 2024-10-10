import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AppImagePicker extends StatefulWidget {
  final String title;
  final void Function(File?)? onImageSelected;

  const AppImagePicker({
    super.key,
    required this.title,
    this.onImageSelected,
  });

  @override
  State<AppImagePicker> createState() => _AppImagePickerState();
}

class _AppImagePickerState extends State<AppImagePicker> {
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      // Callback to send the selected image file
      widget.onImageSelected?.call(_image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.title, ),
        const SizedBox(height: 10),
        _image != null
            ? Image.file(_image!, height: 150, width: 150, fit: BoxFit.cover)
            : Container(
          height: 150,
          width: 150,
          color: Colors.grey[200],
          child: const Icon(Icons.image, size: 50, color: Colors.grey),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: () => _pickImage(ImageSource.gallery),
              icon: const Icon(Icons.photo),
              label: const Text('Gallery'),
            ),
            ElevatedButton.icon(
              onPressed: () => _pickImage(ImageSource.camera),
              icon: const Icon(Icons.camera),
              label: const Text('Camera'),
            ),
          ],
        ),
      ],
    );
  }
}
