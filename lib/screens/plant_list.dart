import 'dart:io';

import 'package:flutter/material.dart';
import 'package:planthydrator/helpers/sql_helper.dart';
import 'package:planthydrator/helpers/plant_model.dart';

class PlantsList extends StatefulWidget {
  const PlantsList({super.key});

  @override
  State<PlantsList> createState() => _PlantsListState();
}

class _PlantsListState extends State<PlantsList> {
  List<Plant> _plants = [];

  @override
  void initState() {
    super.initState();
    _loadPlants();
  }

  void _loadPlants() async {
    final List<Map<String, dynamic>> maps = await SQLHelper.getAllItems();

    setState(() {
      _plants = List.generate(
        maps.length,
        (index) => Plant(
          id: maps[index]['id'],
          name: maps[index]['name'],
          image: maps[index]['image'],
          wateringFrequency: maps[index]['wateringFrequency'],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _plants.length,
      itemBuilder: (context, index) {
        final plant = _plants[index];
        return ListTile(
          leading: plant.image.isNotEmpty
              ? Image.file(File(plant.image))
              : const Icon(Icons.image, size: 40),
          title: Text(plant.name),
          subtitle: Text('Water every ${plant.wateringFrequency} days'),
        );
      },
    );
  }
}
