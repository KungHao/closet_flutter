import 'package:closet_flutter/database/data/album.dart';
import 'package:closet_flutter/database/database_helper.dart';

class AlbumDB {
  final dbHelper = DatabaseHelper.instance;

  // Singleton 單例模式，確保一個類別只有一個實例
  AlbumDB._privateConstructor();

  static final AlbumDB instance = AlbumDB._privateConstructor();

  // insert data
  void insert() async {
    var album = Album(id: 1, albumName: 'T-shirt', imageId: 11);

    dbHelper.insert(album.toMap());

    print('---Insert 結束---');
  }

  // query data
  void query() async {
    final rows = await dbHelper.queryAll();
    print('result:');
    rows.forEach((element) {
      print(element);
    });
    print('end of query');
  }
}
