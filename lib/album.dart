import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:closet_flutter/albumNotifier.dart';

class AlbumScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AlbumScreen();
  }
}

class _AlbumScreen extends State<AlbumScreen> {
  String albumName = "";

  @override
  Widget build(BuildContext context) {
    // final albumTitle = Provider.of<AlbumPassNotifier>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("Album Title"), centerTitle: true),
      body: Center(
        child: Consumer<AlbumPassNotifier>(
          builder: (context, album, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Album Title:'),
                Text('${album.title}'),
                ElevatedButton(
                  child: Text(album.title),
                  onPressed: () {
                    print('test button');
                  },
                ),
              ],
            );
          },
        ),
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text('Album Title:'),
        //     Text('$albumTitle.albumTitle'),
        //     ElevatedButton(
        //       child: Text(albumTitle.toString()),
        //       onPressed: () {
        //         print('test button');
        //       },
        //     ),
        //   ],
        // )
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increase Photo',
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            print('add photo');
          });
        },
      ),
    );
  }
}
