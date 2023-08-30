import "dart:io";
import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
// import "package:path/path.dart";
import "package:planthydrator/helpers/sql_helper.dart";

class AddPlant extends StatefulWidget {
  const AddPlant({Key? key}) : super(key: key);

  @override
  State<AddPlant> createState() => _AddPlantState();
}

class _AddPlantState extends State<AddPlant> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _imagePath;
  int? _wateringFrequency;

  void _pickImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  void _pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  void _showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Select Image Source',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: Text(
                'Camera',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              onTap: () {
                _pickImageFromCamera();
                Navigator.pop(context); // Close the dialog after selection
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: Text('Gallery',
                  style: Theme.of(context).textTheme.displaySmall),
              onTap: () {
                _pickImageFromGallery();
                Navigator.pop(context); // Close the dialog after selection
              },
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final Map<String, Object?> plantData = {
        "name": _name,
        "image": _imagePath,
        "wateringFrequency": _wateringFrequency,
      };

      await SQLHelper.insert(plantData);
      print("success");
      // TODO: implement update state when adding new plant
    } else {
      print("error in _submitForm");
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themes = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(16.0),
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "add plant",
              style: themes.textTheme.labelLarge,
              textAlign: TextAlign.left,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Plant Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a plant name';
                }
                return null;
              },
              onSaved: (value) => _name = value,
            ),
            SizedBox(height: 16),
            Center(
              child: GestureDetector(
                onTap: () {
                  _showImageSourceDialog(context);
                },
                child: Container(
                  width: 150,
                  height: 150,
                  color: Colors.grey[300],
                  child: _imagePath == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt, size: 40),
                            Text('Select Image', textAlign: TextAlign.center),
                          ],
                        )
                      : Image.file(File(_imagePath!)),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(labelText: 'Watering Frequency (in days)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a watering frequency';
                }
                final int? intValue = int.tryParse(value);
                if (intValue == null || intValue <= 0) {
                  return 'Please enter a valid number greater than 0';
                }
                return null;
              },
              onSaved: (value) => _wateringFrequency = int.parse(value!),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(200, 50)),
                ),
                onPressed: _submitForm,
                child: Text('Save',
                    style: themes.textTheme.displayLarge!.copyWith(
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
