import 'dart:io';

import 'package:closet_flutter/Utility.dart';
import 'package:closet_flutter/database/photo_db.dart';
import 'package:closet_flutter/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:closet_flutter/albumNotifier.dart';

import 'database/data/photo.dart';
import 'image_page.dart';

class AlbumPage extends StatefulWidget {
  final AlbumInfo albumInfo;
  AlbumPage({required this.albumInfo});

  @override
  State<StatefulWidget> createState() {
    return _AlbumPage(albumInfo: albumInfo);
  }
}


// List<String> photos = [
//   'images/1.jpg',
//   'images/2.jpg',
//   'images/3.jpg',
//   'images/4.jpg',
//   'images/5.jpg',
//   'images/6.jpg',
//   'images/7.jpg',
//   'images/8.jpg',
//   'images/9.jpg',
//   'images/10.jpg',
//   'images/11.jpg',
//   'images/12.jpg',
//   'images/13.jpg',
//   'images/14.jpg',
//   'images/15.jpg',
//   'images/16.jpg',
// ];

class _AlbumPage extends State<AlbumPage> {
  final AlbumInfo albumInfo;
  _AlbumPage({required this.albumInfo});
  List<Photo> photos = [];
  
  getPhotoList() {
    PhotoDB.instance.queryPhoto(albumInfo.albumName).then((_photos) {
      setState(() {
        photos = _photos;
        print('Photos:$photos');
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getPhotoList();
  }

  _openGallery() {
    ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50).then((imgFile) async {
        String imgStr = Utility.base64String(await imgFile!.readAsBytes());
        PhotoDB.instance.addPhoto(albumInfo.albumName, imgStr);
        getPhotoList();
      });
    Navigator.of(context).pop();
  }

  _openCamera() {
    ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50).then((imgFile) async {
        String imgString = Utility.base64String(await imgFile!.readAsBytes());
        print(imgString);
        print(Utility.imageFromBase64String(imgString));
        PhotoDB.instance.addPhoto(albumInfo.albumName, imgString);
      });
    Navigator.of(context).pop();
  }
  
  _showDialog(context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Choose one way to add photo."),
            actions: [
              IconButton(
                  onPressed: () {
                    print('open camera');
                    _openCamera();
                  },
                  icon: Icon(Icons.camera_alt)),
              IconButton(
                  onPressed: () {
                    print('open gallery');
                    _openGallery();
                  },
                  icon: Icon(Icons.album_rounded))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // final albumInfo = Provider.of<AlbumInfo>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text(albumInfo.albumName), centerTitle: true, actions: [
          IconButton(
              tooltip: 'Refresh',
              icon: Icon(Icons.lock, color: Colors.black),
              onPressed: () async {
                // String _albumName = await _inputDialog(context);
                // _addAlbum(_albumName);
                showToast('Refresh');
                getPhotoList();
              })
        ]),
      body: Center(
        child: Consumer<AlbumInfo>(
          builder: (context, album, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                              crossAxisCount: 3, //每行x列
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
                                              photo: photos[index])));
                                },
                                onLongPress: () {
                                  print('delete photo');
                                },
                                child: Hero(
                                    tag: '${photos[index].id}',
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          // image: AssetImage(photos[index].photoName!),
                                          image: MemoryImage(Utility.dataFromBase64String(photos[index].photo!)),
                                          fit: BoxFit.cover
                                        )
                                      )
                                ))
                              );
                            },
                            itemCount: photos.length)))
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
