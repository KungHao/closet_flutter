import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  final String imagePath;

  ImagePage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("$imagePath"), centerTitle: true),
        body: Container(
          child: Column(
            children: [
              Expanded(
                  //     child: Container(
                  //       decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.only(
                  //           bottomLeft: Radius.circular(20),
                  //           bottomRight: Radius.circular(30)),
                  //       image: DecorationImage(image: AssetImage(imagePath))),
                  // )
                  child: Hero(
                      tag: 'image$imagePath',
                      child: Container(
                        decoration: BoxDecoration(
                            // borderRadius: BorderRadius.only(
                            //     bottomLeft: Radius.circular(20),
                            //     bottomRight: Radius.circular(30)),
                            image: DecorationImage(
                                image: AssetImage(imagePath),
                                fit: BoxFit.cover)),
                      )))
            ],
          ),
        ));
  }
}
