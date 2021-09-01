import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String _msg) {
  Fluttertoast.showToast(
      msg: _msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.black45,
      textColor: Colors.white,
      webBgColor: '#a0a0a0',
      webPosition: 'center',
      fontSize: 16.0);
}

// _scaffoldMessenger(content, {duration: 300}) {
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(content), duration: Duration(milliseconds: duration)));
// }




