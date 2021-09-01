import 'package:closet_flutter/albumNotifier.dart';
import 'package:closet_flutter/home_page.dart';
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
        ChangeNotifierProvider<AlbumInfo>(create: (context) => AlbumInfo())
      ],
      child: MaterialApp(
        title: 'Closet',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: IndexPage(),
      ),
    );
  }
}
