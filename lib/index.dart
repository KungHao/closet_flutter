import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './utils.dart';

import 'package:closet_flutter/album.dart';
import 'package:closet_flutter/albumNotifier.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IndexPage();
  }
}

class _IndexPage extends State<IndexPage> {
  TextEditingController _textFieldController = TextEditingController();
  String _valueText = '';
  final titles = ["Album 1", "Album 2", "Album 3"];

  _showInputDialog(context) async {
    return showDialog<String>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Please Input an Album Name"),
            content: TextField(
              onChanged: (value) {
                _valueText = value;
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Input here"),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child: const Text('CANCEL'),
                onPressed: () {
                  _textFieldController.clear(); // clear textfield
                  Navigator.of(context).pop("user_press_cancel_btn");
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child: const Text('OK'),
                onPressed: () {
                  _textFieldController.clear(); // clear textfield
                  Navigator.of(context).pop(_valueText);
                },
              ),
            ],
          );
        });
  }

  _createAlbumOnPressed(albumName) {
    setState(() {
      if (albumName != "user_press_cancel_btn") {
        showToast("Create album $albumName Succeed!");
        titles.add(albumName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final album = Provider.of<AlbumPassNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Closet"),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //       tooltip: 'Add',
        //       icon: Icon(Icons.add, color: Colors.white),
        //       onPressed: () async {
        //         String _albumName = await _showInputDialog(context);
        //         _createAlbumOnPressed(_albumName);
        //       })
        // ],
      ),
      body: ListView.builder(
          itemCount: titles.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  // showToast(titles[index]);
                  // route to album titles[index]
                  album.passTitle(titles[index]);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AlbumScreen()));
                },
                title: Text(titles[index]),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String _albumName = await _showInputDialog(context);
          _createAlbumOnPressed(_albumName);
        },
        tooltip: 'Show Alert',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
