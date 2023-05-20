import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLHelper {
  static Future<void> createTables(Database database) async {
    await database.execute("""
    DROP TABLE IF EXISTS newAddedCourses
  """);
    await database.execute("""
      CREATE TABLE IF NOT EXISTS courses(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        level INTEGER NOT NULL,
        courseName TEXT NOT NULL,
        courseWeight REAL NOT NULL,
        gradingLetter TEXT NOT NULL,
        gradingLetterValue REAL NOT NULL,
        isCourseSelected INTEGER NOT NULL,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
    """);

    await database.execute("""
      CREATE TABLE IF NOT EXISTS newAddedCourses(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        level INTEGER NOT NULL,
        courseName TEXT NOT NULL,
        courseWeight REAL NOT NULL,
        gradingLetter TEXT NOT NULL,
        gradingLetterValue REAL NOT NULL,
        isCourseSelected INTEGER NOT NULL,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
    """);
  }

  static Future<Database> db() async {
    return openDatabase(
      join(await getDatabasesPath(), 'courses.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<Database> db2() async {
    return openDatabase(
      join(await getDatabasesPath(), 'newAddedCourses.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (journal) for adding to main functions
  static Future<Object?> createItem(
    int? level,
    String? courseName,
    double? courseWeight,
    String? gradingLetter,
    double? gradingLetterValue,
    int? isCourseSelected,
  ) async {
    final db = await SQLHelper.db();

    // Check if the course already exists in the database
    final existingCourses = await db.query(
      'courses',
      where: 'courseName = ?',
      whereArgs: [courseName],
      limit: 1,
    );
    if (existingCourses.isNotEmpty) {
      // Update the existing entry
      final existingCourse = existingCourses.first;
      final id = existingCourse['id'];
      final data = {
        'level': level,
        'courseName': courseName,
        'courseWeight': courseWeight,
        'gradingLetter': gradingLetter,
        'gradingLetterValue': gradingLetterValue,
        'isCourseSelected': isCourseSelected,
        'createdAt': DateTime.now().toString(),
      };
      await db.update('courses', data, where: 'id = ?', whereArgs: [id]);
      return id;
    } else {
      // Create a new entry
      final data = {
        'level': level,
        'courseName': courseName,
        'courseWeight': courseWeight,
        'gradingLetter': gradingLetter,
        'gradingLetterValue': gradingLetterValue,
        'isCourseSelected': isCourseSelected,
      };
      final id = await db.insert('courses', data,
          conflictAlgorithm: ConflictAlgorithm.replace);
      return id;
    }
  }

  // Create new item (journal) for adding to second screen

  static Future<Object?> createItemSecondWindow(
    int? level,
    String? courseName,
    double? courseWeight,
    String? gradingLetter,
    double? gradingLetterValue,
    int? isCourseSelected,
  ) async {
    final db = await SQLHelper.db2();

    // Check if the course already exists in the database
    final existingCourses = await db.query(
      'newAddedCourses',
      where: 'courseName = ?',
      whereArgs: [courseName],
      limit: 1,
    );
    if (existingCourses.isNotEmpty) {
      // Update the existing entry
      final existingCourse = existingCourses.first;
      final id = existingCourse['id'];
      final data = {
        'level': level,
        'courseName': courseName,
        'courseWeight': courseWeight,
        'gradingLetter': gradingLetter,
        'gradingLetterValue': gradingLetterValue,
        'isCourseSelected': isCourseSelected,
        'createdAt': DateTime.now().toString(),
      };
      await db
          .update('newAddedCourses', data, where: 'id = ?', whereArgs: [id]);
      return id;
    } else {
      // Create a new entry
      final data = {
        'level': level,
        'courseName': courseName,
        'courseWeight': courseWeight,
        'gradingLetter': gradingLetter,
        'gradingLetterValue': gradingLetterValue,
        'isCourseSelected': isCourseSelected,
      };
      final id = await db.insert('newAddedCourses', data,
          conflictAlgorithm: ConflictAlgorithm.replace);
      return id;
    }
  }

  // Read all items (journals)
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('courses', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItemsSecondWindow() async {
    final db = await SQLHelper.db2();
    return db.query('newAddedCourses', orderBy: "id");
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('courses', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(
      int level,
      String courseName,
      double courseWeight,
      String gradingLetter,
      double gradingLetterValue,
      int isCourseSelected) async {
    final db = await SQLHelper.db();

    final data = {
      'level': level,
      'courseName': courseName,
      'courseWeight': courseWeight,
      'gradingLetter': gradingLetter,
      'gradingLetterValue': gradingLetterValue,
      'isCourseSelected': isCourseSelected,
      'createdAt': DateTime.now().toString()
    };

    final result = await db.update('courses', data,
        where: "courseName = ?", whereArgs: [courseName]);
    return result;
  }

  static Future<int> updateItemSecondWindow(
      int level,
      String courseName,
      double courseWeight,
      String gradingLetter,
      double gradingLetterValue,
      int isCourseSelected) async {
    final db = await SQLHelper.db2();

    final data = {
      'level': level,
      'courseName': courseName,
      'courseWeight': courseWeight,
      'gradingLetter': gradingLetter,
      'gradingLetterValue': gradingLetterValue,
      'isCourseSelected': isCourseSelected,
      'createdAt': DateTime.now().toString()
    };

    final result = await db.update('newAddedCourses', data,
        where: "courseName = ?", whereArgs: [courseName]);
    return result;
  }

  static Future<void> deleteItem(String name) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("courses", where: "courseName = ?", whereArgs: [name]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<void> deleteItemSecondWindow(String name) async {
    final db2 = await SQLHelper.db2();
    try {
      await db2.delete("newAddedCourses",
          where: "courseName = ?", whereArgs: [name]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
