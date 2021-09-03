import 'package:closet_flutter/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:closet_flutter/albumNotifier.dart';

import 'image_page.dart';

class AlbumPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AlbumPage();
  }
}

List<String> _images = [
  'images/1.jpg',
  'images/2.jpg',
  'images/3.jpg',
  'images/4.jpg',
  'images/5.jpg',
  'images/6.jpg',
  'images/7.jpg',
  'images/8.jpg',
  'images/9.jpg',
  'images/10.jpg',
  'images/11.jpg',
  'images/12.jpg',
  'images/13.jpg',
  'images/14.jpg',
  'images/15.jpg',
  'images/16.jpg',
];

class _AlbumPage extends State<AlbumPage> {
  String albumName = "";

  _showDialog(context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Choose one way to add photo."),
            actions: [
              IconButton(
                  onPressed: () {
                    showToast("shit");
                  },
                  icon: Icon(Icons.camera_alt)),
              IconButton(
                  onPressed: () {
                    showToast("fuck");
                  },
                  icon: Icon(Icons.album_rounded))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // final albumTitle = Provider.of<AlbumPassNotifier>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("Album Title"), centerTitle: true),
      body: Center(
        child: Consumer<AlbumInfo>(
          builder: (context, album, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text('Album Title:'),
                // Text('${album.title}'),
                // ElevatedButton(
                //   child: Text(album.title),
                //   onPressed: () {
                //     print('test button');
                //   },
                // ),
                Expanded(
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) {
                              return RawMaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ImagePage(
                                              imagePath: _images[index])));
                                },
                                // child: Container(
                                //   decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(15),
                                //       image: DecorationImage(
                                //           image: AssetImage(_images[index]),
                                //           fit: BoxFit.cover)),
                                // )
                                child: Hero(
                                    tag: 'image$index',
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                              image: AssetImage(_images[index]),
                                              fit: BoxFit.cover)),
                                    )),
                              );
                            },
                            itemCount: _images.length)))
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increase Photo',
        child: Icon(Icons.add),
        onPressed: () {
          _showDialog(context);
          setState(() {
            print('add photo');
          });
        },
      ),
    );
  }
}
