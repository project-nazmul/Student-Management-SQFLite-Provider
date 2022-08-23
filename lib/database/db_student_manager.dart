import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_crud/model/student.dart';

class DbStudentManager extends ChangeNotifier{
  late Database _database;

  Future openDb() async {
      _database = await openDatabase(
          join(await getDatabasesPath(), "ss.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE student(id INTEGER PRIMARY KEY autoincrement, name TEXT, course TEXT)",

        );
      } );

  }

  insertStudent(Student student) async {
    await openDb();
    await _database.insert('student', student.toMap());
    notifyListeners();
  }

  Future<List<Student>> getStudentList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('student');
    return List.generate(maps.length, (i) {
      return Student(
          id: maps[i]['id'], name: maps[i]['name'], course: maps[i]['course']);
    });
  }

  updateStudent(Student student) async {
    await openDb();
    await _database.update('student', student.toMap(), where: "id = ?", whereArgs: [student.id]);
    notifyListeners();

  }

  deleteStudent(int id) async {
    await openDb();
    await _database.delete(
        'student',
        where: "id = ?", whereArgs: [id]
    );
    notifyListeners();
  }
}


