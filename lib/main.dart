import 'package:cook/widget/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:cook/net/net.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    getCategory();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        centerTitle: true,
        elevation: 1,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SnackButton(),
            Text(
              '分类',
            ),
            Container(
              height: 100,
              child: GridView.count(
                crossAxisCount: 3,
                children: <Widget>[
                  Text('test'),
                  Text('test'),
                  Text('test'),
                  Text('test'),
                  Text('test'),
                ],
              ),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('home'),
              backgroundColor: Colors.lightGreenAccent),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_alert,
              ),
              title: Text(
                'center',
                style: TextStyle(color: Colors.amberAccent),
              ),
              backgroundColor: Colors.cyan),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.shifting,
        fixedColor: Colors.lightGreenAccent,
        iconSize: 25,
      ),
      drawer: Container(
        child: Drawer(
          elevation: 5,
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text('center'),
              )
            ],
          ),
        ),
        width: 240,
      ),
    );
  }
}
