import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planthydrator/screens/add_plant.dart';
import 'package:planthydrator/screens/plant_list.dart';
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
  // List<Map<String, dynamic>> _plants = [];

  @override
  void initState() {
    super.initState();
    // _refreshPlants();
    // print("num of plants: ${_plants.length}");
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themes = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: themes.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.add),
        onPressed: () => showModalBottomSheet(
          backgroundColor: Colors.transparent,
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
              "plants list",
              style: (themes.textTheme.displayMedium)!.copyWith(
                fontSize: 24,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: 300,
            child: PlantsList(),
          ),
        ],
      ),
    );
  }
}
