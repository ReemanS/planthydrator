import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planthydrator/screens/add_plant.dart';
import 'package:planthydrator/screens/search.dart';
import 'package:planthydrator/helpers/sql_helper.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appBarTheme = Theme.of(context).appBarTheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarTheme.backgroundColor,
        elevation: appBarTheme.elevation,
        toolbarHeight: appBarTheme.toolbarHeight,
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {},
          ),
        ),
        title: Text(
          'Plant Hydrator',
          style: textTheme.displayMedium,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {
                showSearch(context: context, delegate: SearchPlantsDelegate());
              },
            ),
          ),
        ],
      ),
      body: const BodySection(),
    );
  }
}

class BodySection extends StatefulWidget {
  const BodySection({super.key});

  @override
  State<BodySection> createState() => _BodySectionState();
}

class _BodySectionState extends State<BodySection> {
  List<Map<String, dynamic>> _plants = [];

  bool _isLoading = true;

  void _refreshPlants() async {
    final List<Map<String, dynamic>> data = await SQLHelper.getAllItems();
    setState(() {
      _plants = data;
      _isLoading = false;
    });
  }

  String? _imagePath;
  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  final TextEditingController _plantNameController = TextEditingController();
  final TextEditingController _plantImageController = TextEditingController();
  final TextEditingController _plantLastWateringDateController =
      TextEditingController();
  final TextEditingController _plantWateringFrequencyController =
      TextEditingController();

  // TODO: implement separate add and edit forms

  void _showForm(int? id) async {
    if (id != null) {
      final existingPlant =
          _plants.firstWhere((element) => element['id'] == id);
      _plantNameController.text = existingPlant['name'];
      _plantImageController.text = existingPlant['image'];
      _plantLastWateringDateController.text = existingPlant['lastWateringDate'];
      _plantWateringFrequencyController.text =
          existingPlant['wateringFrequency'];
    } else {
      ThemeData themes = Theme.of(context);
      showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) =>
              Container(
            padding: EdgeInsets.fromLTRB(
              15,
              15,
              15,
              MediaQuery.of(context).viewInsets.bottom + 120,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  controller: _plantImageController,
                  decoration:
                      const InputDecoration(labelText: "Enter plant name"),
                ),
                const SizedBox(height: 5),
                _imagePath == null
                    ? InkWell(
                        onTap: () => _pickImage,
                        child: Container(
                          width: 400,
                          height: 400,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.add_a_photo, size: 30),
                              const SizedBox(height: 8),
                              Text('Select an image',
                                  style: themes.textTheme.labelSmall),
                            ],
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          Image.file(
                            File(_imagePath!),
                            width: 400,
                            height: 400,
                          ),
                          const SizedBox(height: 5),
                          // Select another image
                          TextButton(
                            onPressed: _pickImage,
                            child: Text(
                              'Select another image',
                              style: themes.textTheme.labelSmall!.copyWith(
                                color: themes.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 5),
                TextField(
                  controller: _plantWateringFrequencyController,
                  decoration:
                      const InputDecoration(hintText: "Watering Frequency"),
                ),
                const SizedBox(height: 5),
                Text(
                  "Last Watering Date: ${_plantLastWateringDateController.text}",
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshPlants();
    print("num of plants: ${_plants.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.add),
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (context) => AddPlant(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              "Water today",
              style: (Theme.of(context).textTheme.displayMedium)!.copyWith(
                fontSize: 24,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const Placeholder(),
        ],
      ),
    );
  }
}
