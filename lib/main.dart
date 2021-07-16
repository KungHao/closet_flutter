import 'package:flutter/material.dart';

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
  int _counter = 0;

  _showAlert() {
    return showDialog(
      context: 'context', 
      builder: {
        return AlertDialog(
          title: Text("Title"),

        )
      }
    )
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _appBarButton() {
    setState(() {
      _counter += 10;
    });
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
            icon: Icon(
              Icons.add,
              color: Colors.white
            ),
            onPressed: _appBarButton,
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          ListView(
            shrinkWrap: true, // 是否根據子組件的總長度來設置
            children: item.map((element) => Text(element)).tolist(),
          )
        ],
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     Text('you are an ass hole!'),
        //     Text(
        //       'You have clicked the button this many times:',
        //     ),
        //     Text(
        //       '$_counter',
        //       style: Theme.of(context).textTheme.headline4,
        //     ),
        //   ],
        // ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Show Alert',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
