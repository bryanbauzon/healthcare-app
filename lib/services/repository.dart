import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/user.dart';

class Repository {
  Database? _database;
  static final Repository instance = Repository._init();
  Repository._init();

  static const String dbNAME = 'user.db';
  static const String tableUSER = 'user';
  static const String colID = '_id';
  static const String colLN = 'lastname';
  static const String colFN = 'firstname';
  static const String colMN = 'middleName';
  static const String colAddress = 'address';
  static const String colEmpId = 'empId';
  static const String colPosition = 'position';
  static const String colPassword = 'password';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('user.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE $tableUSER($colID INTEGER PRIMARY KEY AUTOINCREMENT,
                                       $colLN TEXT NOT NULL,
                                        $colFN TEXT NOT NULL,
                                         $colMN TEXT NOT NULL,
                                          $colAddress TEXT NOT NULL,
                                           $colEmpId TEXT NOT NULL,
                                            $colPosition TEXT NOT NULL,
                                             $colPassword TEXT NOT NULL)''');
  }

  Future<void> insert({required User user}) async {
    try {
      final db = await database;
      db.insert(tableUSER, user.toMap());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> checkIfUserExists({required String empId}) async {
    try {
      final db = await database;
      List<Map> user = await db.rawQuery(
          'SELECT $colEmpId FROM $tableUSER WHERE $colEmpId =?', [empId]);
      if (user.isNotEmpty) {
        return Future<bool>.value(true);
      }
    } catch (e) {
      debugPrint('e: $e');
    }
    return Future<bool>.value(false);
  }

  Future<bool> validateCredentials(
      {required String empId, required String password}) async {
    try {
      final db = await database;
      final user = await db.rawQuery(
          'SELECT 1 FROM $tableUSER WHERE $colEmpId = ? AND $colPassword = ?',
          [empId, password]);

      return user.isNotEmpty;
    } catch (e) {
      debugPrint('e: $e');
    }
    return false;
  }

  Future<User> getUserDetails(
      {required String empId, required String password}) async {
    try {
      final db = await database;
      final user = await db.rawQuery(
          'SELECT * FROM $tableUSER WHERE $colEmpId = ? AND $colPassword = ?',
          [empId, password]);

      return User.fromMap(user.first);
    } catch (e) {
      debugPrint('e: $e');
    }
    return User(
        lastName: '',
        firstName: '',
        middleName: '',
        address: '',
        empId: '',
        position: '',
        password: '');
  }
}
