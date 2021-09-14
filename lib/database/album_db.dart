import 'package:closet_flutter/database/data/album.dart';
import 'package:closet_flutter/database/albumDB_helper.dart';

class AlbumDB {
  final dbHelper = AlbumDBHelper.instance;
  
  // Singleton 單例模式，確保一個類別只有一個實例
  AlbumDB._privateConstructor();

  static final AlbumDB instance = AlbumDB._privateConstructor();

  // insert data
  void addAlbum(String _albumName) async {
    Album album = Album(albumName: _albumName);
    dbHelper.addAlbum(album.toMap());
    print('---Insert Success---');
  }

  void deleteAlbum(Album album) async {
    // Album album = Album(albumName: _albumName);
    dbHelper.deleteAlbum(album.id!);
    dbHelper.deletePhotoByAlbum(album.albumName!);
    print('---Delete Success---');
  }

  void updateAlbum(Album album, String newAlbum) async {
    // album.albumName = newAlbum;
    dbHelper.updateAlbum(album.toMap(), newAlbum);
    dbHelper.updateAlbumByName(album.toMap(), newAlbum);
    print('---Update Success---');
  }

  // query data
  Future<List<Album>> queryAlbum() async {
    List<Album> albums = [];
    await dbHelper.queryAlbum().then((res) {
      if (res.isNotEmpty) {
        albums = res.map((albumMap) => Album.fromMap(albumMap)).toList();
      }
    });
    return albums;
  }

  Future<bool> checkAlbumExist(String albumName) async {
    List<Album> albums = [];
    bool isExist = true;
    await dbHelper.queryAlbumByName(albumName).then((res) {
      if (res.isEmpty) {
        isExist = false;
      }
    });
    return isExist;
  }
}
