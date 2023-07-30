import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rebuni/core/utils/colors.dart';

import '../bloc/image_picker_bloc/image_picker_bloc.dart';

class ImagePickerTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;

  const ImagePickerTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.icon,
  }) : super(key: key);

  @override
  State<ImagePickerTextField> createState() => _ImagePickerTextFieldState();
}

class _ImagePickerTextFieldState extends State<ImagePickerTextField> {
  
  addImagePickerEvent(File file) {
    BlocProvider.of<ImagePickerBloc>(context).add(AddImageEvent(file));
  }

  Future<void> _pickImage(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final file = File(image.path);
      // You can process the file here
      addImagePickerEvent(file);
      
      final imageName = file.path.split('/').last;
      widget.controller.text = imageName;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image selected')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _pickImage(context);
      },
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              enabled: false,
              decoration: InputDecoration(
                  hintText: widget.hintText,
                  prefixIcon: Icon(widget.icon),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: textFieldColor),
            ),
          ),
        ],
      ),
    );
  }
}
