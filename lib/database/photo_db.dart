import 'package:closet_flutter/database/data/photo.dart';
import 'package:closet_flutter/database/albumDB_helper.dart';

class PhotoDB {
  final dbHelper = AlbumDBHelper.instance;

  // Singleton 單例模式，確保一個類別只有一個實例
  PhotoDB._privateConstructor();

  static final PhotoDB instance = PhotoDB._privateConstructor();

  // insert data
  void addPhoto(String _albumName, String _photoStr) async {
    Photo photo = Photo(albumName: _albumName, photo: _photoStr);
    dbHelper.addPhoto(photo.toMap());
    print('---Insert Success---');
  }

  void deletePhoto(Photo album) async {
    // Photo album = Photo(albumName: _albumName);
    dbHelper.deletePhoto(album.id!);
    print('---Delete Success---');
  }

  // void update(Photo album, String newPhoto) async {
  //   album.albumName = newPhoto;
  //   dbHelper.update(album.toMap());
  // }

  // query data
  Future<List<Photo>> queryPhoto(_albumName) async {
    List<Photo> photos = [];

    await dbHelper.queryPhoto(_albumName).then((res) {
      if (res.isNotEmpty) {
        photos = res.map((albumMap) => Photo.fromMap(albumMap)).toList();
      }
    });
    return photos;
  }
}
