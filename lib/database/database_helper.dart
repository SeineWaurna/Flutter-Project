import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelper {
  static final _databaseName="MyDb.db";
  static final _databaseVersion=1;
  static final table="my_table";
  static final columnId="_id";
  static var columnName="name";
  static var columnAge="age";

  // สร้าง Instance สำหรัยเรียกใช้ db ก่อน
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance=DatabaseHelper._privateConstructor();

  // สร้างการเชื่อมต่อกับ db
  static Database? _database;
  Future<Database?> get database async {
    if(_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _oncreate);
  }

  // สร้าง table
  Future _oncreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT WILL NOT NULL,
        $columnAge TEXT WILL NOT NULL,
      )
    ''');
  }

  // สร้าง method สำหรับเพิ่มข้อมูล
  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(table, row);
  }

  // สร้าง method สำหรับอ่านข้อมูล
  Future<List<Map<String, dynamic>>> queryAllRow() async {
    Database? db = await instance.database;
    return await db!.query(table);
  }

  // สร้าง method สำหรับอ่านข้อมูลแบบมีเงื่อนไข
  Future<List<Map<String, dynamic>>> queryNameRow(String name) async {
    Database? db = await instance.database;
    return await db!.query(table, where: '$columnName = ?', whereArgs: [name]);
  }

  Future<List<Map<String, dynamic>>> queryIdRow(int id) async {
    Database? db = await instance.database;
    return await db!.query(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> queryAgeRow(String age) async {
    Database? db = await instance.database;
    return await db!.query(table, where: '$columnAge = ?', whereArgs: [age]);
  }

  // สร้าง method สำหรับอัพเดทข้อมูล
  Future<int> update(Map<String, dynamic> row, {required int id}) async {
    Database? db = await instance.database;
    return await db!.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // สร้าง method สำหรับลบข้อมูลแบบมีเงื่อนไข
  Future<int> delete(int id) async {
    Database? db = await instance.database;
    return await db!.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}