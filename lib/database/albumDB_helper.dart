import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class AlbumDBHelper {
  static const DATABASE_NAME = "AlbumDB.db";
  static const VERSION = 1;
  static const ALBUM_TABLE = 'albumDB';
  static const PHOTO_TABLE = 'photoDB';

  static final columnId = 'id';
  static final columnAlbumName = 'albumName';
  static final columnPhoto = 'photo';

  AlbumDBHelper._privateConstructor();
  static final AlbumDBHelper instance = AlbumDBHelper._privateConstructor();
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
    String path = join(documentDirectory.path, '$DATABASE_NAME');

    return await openDatabase(path, version: VERSION, onCreate: _onCreate);
  }

  // 建立資料表
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $ALBUM_TABLE(
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnAlbumName TEXT UNIQUE
      )
    ''');
    print('Database $ALBUM_TABLE created.');

    await db.execute('''
      CREATE TABLE $PHOTO_TABLE(
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnAlbumName TEXT,
        $columnPhoto TEXT
      )
    ''');
    print('Database $PHOTO_TABLE created.');
  }

  Future<int> addAlbum(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(ALBUM_TABLE, row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> addPhoto(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(PHOTO_TABLE, row);
  }

  Future<List<Map<String, dynamic>>> queryAlbum() async {
    Database? db = await instance.database;
    return await db!.rawQuery('''
      SELECT * FROM $ALBUM_TABLE
    ''');
  }

  Future<List<Map<String, dynamic>>> queryAlbumByName(String albumName) async {
    Database? db = await instance.database;
    return await db!.rawQuery('''
      SELECT * FROM $ALBUM_TABLE 
      WHERE $columnAlbumName = ?
    ''', [albumName]);
  }

  Future<List<Map<String, dynamic>>> queryPhoto(String albumName) async {
    Database? db = await instance.database;
    return await db!.rawQuery('''
      SELECT * FROM $PHOTO_TABLE 
      WHERE $columnAlbumName = ?
    ''', [albumName]);
  }

  Future<int> updateAlbum(Map<String, dynamic> row, String newAlbum) async {
    Database? db = await instance.database;
    return await db!.rawUpdate('''
      UPDATE $ALBUM_TABLE 
      SET $columnAlbumName = '$newAlbum' 
      WHERE $columnId = ${row['id']}
    ''');
  }

  Future<int> updateAlbumByName(Map<String, dynamic> row, String newAlbum) async {
    Database? db = await instance.database;
    return await db!.rawUpdate('''
      UPDATE $PHOTO_TABLE 
      SET $columnAlbumName = '$newAlbum' 
      WHERE $columnAlbumName = '${row['albumName']}'
    ''');
  }

  Future<int> deleteAlbum(int id) async {
    Database? db = await instance.database;
    return await db!.rawDelete('''
      DELETE FROM $ALBUM_TABLE
      WHERE $columnId = $id
    ''');
  }

  Future<int> deletePhoto(int id) async {
    Database? db = await instance.database;
    return await db!.rawDelete('''
      DELETE FROM $PHOTO_TABLE
      WHERE $columnId = $id
    ''');
  }

  Future<int> deletePhotoByAlbum(String albumName) async {
    Database? db = await instance.database;
    return await db!.rawDelete('''
      DELETE FROM $PHOTO_TABLE
      WHERE $columnAlbumName = '$albumName'
    ''');
  }

}
