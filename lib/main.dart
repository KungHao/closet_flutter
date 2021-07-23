import 'package:closet_flutter/albumNotifier.dart';
import 'package:closet_flutter/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AlbumPassNotifier>(create: (context) => AlbumPassNotifier())
        ],
      child: 
        MaterialApp(
            title: 'Closet',
            theme: ThemeData(
              primarySwatch: Colors.blueGrey,
            ),
            home: IndexPage(),
        ),
      );
  }
}


