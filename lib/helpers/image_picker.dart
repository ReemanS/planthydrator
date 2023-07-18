import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  final TextEditingController imageController = TextEditingController();

  Future<String?> pickImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageController.text = pickedFile.path;
      return pickedFile.path;
    }

    return null;
  }

  Widget buildImageInput(BuildContext context, controller) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap: () {
        pickImage(context);
      },
      decoration: InputDecoration(
        labelText: 'Select image',
        suffixIcon: IconButton(
          onPressed: () {
            pickImage(context);
          },
          icon: const Icon(Icons.photo),
        ),
      ),
    );
  }
}
