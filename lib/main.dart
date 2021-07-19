import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'Closet'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _textFieldController = TextEditingController();
  String _valueText = '';
  final titles = ["Album 1", "Album 2", "Album 3"];

  _showToast(String _msg) {
    Fluttertoast.showToast(
        msg: _msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        webBgColor: '#a0a0a0',
        webPosition: 'center',
        fontSize: 16.0);
  }

  _scaffoldMessenger(content, {duration: 300}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(content), duration: Duration(milliseconds: duration)));
  }

  _showInputDialog() {
    return showDialog<String>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Please Input an Album Name"),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  _valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Input Here"),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child: const Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pop("");
                  });
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child: const Text('OK'),
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pop(_valueText);
                  });
                },
              ),
            ],
          );
        });
  }

  _createAlbumOnPressed(albumName) {
    if (albumName != "") {
      _showToast("Create album $albumName Succeed!");
      titles.add(albumName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          IconButton(
              tooltip: 'Add',
              icon: Icon(Icons.add, color: Colors.white),
              onPressed: () async {
                String _albumName = await _showInputDialog();
                _createAlbumOnPressed(_albumName);
              })
        ],
      ),
      body: ListView.builder(
          itemCount: titles.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  setState(() {
                    titles.add('Album' + (titles.length + 1).toString());
                  });
                  _showToast(titles[index]);
                },
                title: Text(titles[index]),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String _albumName = await _showInputDialog();
          _createAlbumOnPressed(_albumName);
        },
        tooltip: 'Show Alert',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
