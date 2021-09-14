import 'package:closet_flutter/database/data/album.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
  List<Album> albums = [];

  getAlbumList() {
    AlbumDB.instance.queryAlbum().then((_albums) {
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

  _inputDialog(context, String title) async {
    return showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
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

  _addAlbum(_albumName) async {
    if (_albumName != "user_press_cancel_btn") {
      bool isExist = await AlbumDB.instance.checkAlbumExist(_albumName);
      if (isExist) {
        showToast('The album name is duplicated');
      }
      else {
        AlbumDB.instance.addAlbum(_albumName);
        showToast("Create album $_albumName Succeed!");
        getAlbumList();
      }
      
    }
  }

  _editAlbumName(_albums, _albumName) async {
    if (_albumName != "user_press_cancel_btn") {
      bool isExist = await AlbumDB.instance.checkAlbumExist(_albumName);
      if (isExist){
        showToast('The album name is duplicated');
      }
      else {
        AlbumDB.instance.updateAlbum(_albums, _albumName);
        showToast("Edit album $_albumName Succeed!");
        getAlbumList();
      }
    }
  }

  _checkDelete() {
    return AlertDialog(
      title: Text('Delete or Not?'),
      actions: <Widget>[
          TextButton(
          child: Text("CANCEL"),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          ),
          TextButton(
          child: Text("DELETE"),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          ),
      ]
      );
  }

  @override
  Widget build(BuildContext context) {
    final albumInfo = Provider.of<AlbumInfo>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Closet"),
        centerTitle: true,
        actions: [
          IconButton(
              tooltip: 'Refresh',
              icon: Icon(Icons.refresh, color: Colors.black),
              onPressed: () async {
                // String _albumName = await _inputDialog(context);
                // _addAlbum(_albumName);
                showToast('Refresh');
                getAlbumList();
              })
        ],
      ),
      body: ListView.builder(
          itemCount: albums.length,
          itemBuilder: (context, index) {
            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              child: Card(
                child: ListTile(
                  onTap: () {
                    // showToast(titles[index]);
                    // route to album titles[index]
                    albumInfo.albumName = albums[index].albumName!;
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AlbumPage(albumInfo: albumInfo)));
                  },
                  title: Text(albums[index].albumName!),
                ),
              ),
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Edit',
                  color: Colors.blue,
                  icon: Icons.edit,
                  onTap: () async {
                    print('Update list: ${albums[index].albumName}');
                    String _albumName = await _inputDialog(context, 'Please Input Album Name');
                    _editAlbumName(albums[index], _albumName);
                  },
                ),
                IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () async {
                    bool isDelete = await showDialog(barrierDismissible: false, context: context, builder: (context) {
                      return _checkDelete();
                    });
                    if (isDelete) {
                      // print('Delete list: ${albums[index]}');
                      showToast('Delete Album: ${albums[index].albumName} Success!');
                      AlbumDB.instance.deleteAlbum(albums[index]);
                      getAlbumList();
                    }
                  },
                )
              ]);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String _albumName = await _inputDialog(context, 'Please Input Album Name');
          _addAlbum(_albumName);
        },
        tooltip: 'Show Alert',
        child: Icon(Icons.add),
      ),
    );
  }
}
