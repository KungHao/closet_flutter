import 'package:flutter/material.dart';

class AlbumInfo with ChangeNotifier {

  // Private album title
  String _albumName = "" ;

  String get albumName => _albumName;

  set albumName(String newName) {
    _albumName = newName;
    notifyListeners();
  }
}