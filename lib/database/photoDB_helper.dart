import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class PhotoDBHelper {
  static final _databaseName = "PhotoDB.db";
  static final _databaseVersion = 1;
  static final _tableName = 'photo_db';

  static final columnId = 'id';
  static final columnAlbumName = 'albumName';
  static final columnPhotoStr = 'photoStr';

  PhotoDBHelper._privateConstructor();
  static final PhotoDBHelper instance = PhotoDBHelper._privateConstructor();
  static Database? _database;

  // 若是沒有DB則新增，若有則回傳DB。
  // Future<Database> get database async => _database ??= await _initDatabase();
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDatabase();
    return _database;
  }

  // 根據不同裝置找到database的位置
  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, '$_databaseName');

    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  // 建立資料表
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName(
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnAlbumName TEXT,
        $columnPhotoStr TEXT
      )
    ''');
    print('Database $_tableName created.');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(_tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database? db = await instance.database;
    return await db!.query(_tableName);
  }

  Future<List<Map<String, dynamic>>> queryAlbum(String _albumName) async {
    Database? db = await instance.database;
    return await db!.query(_tableName, where: '$columnAlbumName = ?', 
                          whereArgs: [_albumName],
                          columns: [columnAlbumName]);
  }

  Future<int?> queryRawCount() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM $_tableName'));
  }

  // Future<int> update(Map<String, dynamic> row) async {
  //   Database? db = await instance.database;
  //   return await db!.update(_tableName, row, where: '$columnId = ?', whereArgs: [row['id']], conflictAlgorithm: ConflictAlgorithm.ignore);
  // }

  Future<int> delete(int id) async {
    Database? db = await instance.database;
    return await db!.delete(_tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
