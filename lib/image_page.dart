import 'package:closet_flutter/Utility.dart';
import 'package:closet_flutter/database/data/photo.dart';
import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  final Photo photo;

  ImagePage({required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onVerticalDragDown: (details) {
          Navigator.pop(context);
        },
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Hero(
                  tag: '${photo.photo}',
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)
                      ),
                      image: DecorationImage(
                        image: MemoryImage(Utility.dataFromBase64String(photo.photo!)),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
