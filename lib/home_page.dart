import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './utils.dart';

import 'package:closet_flutter/album_page.dart';
import 'package:closet_flutter/albumNotifier.dart';

import 'database/album_db.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IndexPage();
  }
}

class _IndexPage extends State<IndexPage> {
  TextEditingController _textFieldController = TextEditingController();
  List<String> albums = [];
  
  getAlbumList() {
    AlbumDB.instance.query().then((_albums) {
      setState(() {
        albums = _albums;
        print('Albums:$albums');
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getAlbumList();
  }


  _showInputDialog(context) async {
    return showDialog<String>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Please Input an Album Name"),
            content: TextField(
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
                  Navigator.of(context).pop(_textFieldController.text);
                  _textFieldController.clear(); // clear textfield
                },
              ),
            ],
          );
        });
  }

  _createAlbumOnPressed(_albumName) {
    // setState(() {
    //   if (albumName != "user_press_cancel_btn") {
    //     AlbumDB.instance.insert('testAlbum');
    //     showToast("Create album $albumName Succeed!");
    //     // titles.add(albumName);
    //   }
    // });
    if (_albumName != "user_press_cancel_btn") {
      AlbumDB.instance.insert(_albumName);
      showToast("Create album $_albumName Succeed!");
      getAlbumList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final album = Provider.of<AlbumInfo>(context);
    
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
          itemCount: albums.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  // showToast(titles[index]);
                  // route to album titles[index]
                  album.albumTitle = albums[index];
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AlbumPage()));
                },
                title: Text(albums[index]),
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
      ),
    );
  }
}
