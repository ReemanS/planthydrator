import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute(
        "CREATE TABLE plants (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, image TEXT, lastWateringDate TEXT, wateringFrequency INTEGER, createdAt TEXT)");
  }

  static Future<sql.Database> openDB() async {
    return sql.openDatabase(
      'plants.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> insert(Map<String, dynamic> data) async {
    final sql.Database database = await openDB();
    return database.insert("plants", data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getAllItems() async {
    final sql.Database database = await openDB();
    return database.query("plants", orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final sql.Database database = await openDB();
    return database.query("plants", where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(int id, String? name, String? image,
      String? lastWateringDate, int? wateringFrequency) async {
    final sql.Database database = await openDB();

    final Map<String, dynamic> data = {
      "name": name,
      "image": image,
      "lastWateringDate": lastWateringDate,
      "wateringFrequency": wateringFrequency,
    };

    final int result =
        await database.update("plants", data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final sql.Database database = await openDB();
    try {
      await database.delete("plants", where: "id = ?", whereArgs: [id]);
    } catch (error) {
      debugPrint("Error deleting item: $error");
    }
  }
}
