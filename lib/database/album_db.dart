import 'package:closet_flutter/database/data/album.dart';
import 'package:closet_flutter/database/database_helper.dart';

class AlbumDB {
  final dbHelper = DatabaseHelper.instance;

  // Singleton 單例模式，確保一個類別只有一個實例
  AlbumDB._privateConstructor();

  static final AlbumDB instance = AlbumDB._privateConstructor();

  // insert data
  void insert(String _albumName) async {
    Album album = Album(albumName: _albumName);

    dbHelper.insert(album.toMap());

    print('---Insert 結束---');
  }

  // query data
  Future<List<String>> query() async {
    List<String> res = [];
    await dbHelper.queryAll().then((value) {
      value.forEach((element) {
        res.add(element['albumName']);
      });
    });
    return res;
    // print('result:');
    // rows.forEach((element) {
    //   print(element);
    // });
    // print('end of query');

  }
}
