import 'package:flutter/material.dart';

class AlbumInfo with ChangeNotifier {

  // Private album title
  String _title = "" ;

  String get title => _title;

  set albumTitle(String newTitle) {
    _title = newTitle;
    notifyListeners();
  }
}