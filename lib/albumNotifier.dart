import 'package:flutter/material.dart';

class AlbumPassNotifier with ChangeNotifier {

  // Private album title
  String _title = "" ;

  String get title => _title;

  passTitle(String albumTitle) {
    _title = albumTitle;
    notifyListeners();
  }
}