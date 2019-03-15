import 'package:cook/entity/cook_bean.dart';
import 'package:cook/page/category_page.dart';
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
  int _currentIndex = 0;
  List<CategoryInfo> _category = [];

  @override
  void initState() {
    super.initState();
    getCategory((CategoryInfo info) {
      setState(() {
        _category = info.childs;
      });
    });
  }

  generateCategoryItem() {
    return List.generate(_category.length + 1, (index) {
      return InkWell(
          onTap: () {
            if (index < _category.length) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return CategoryPage(
                  list: _category,
                  index: index,
                );
              }));
            }
          },
          child: Center(
            child: Text(index < _category.length
                ? _category[index].categoryInfo.name
                : '我的收藏'),
          ));
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
      body: ListView(
        children: <Widget>[
          SnackButton(),
          Text(
            '分类',
          ),
          Container(
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              childAspectRatio: 4,
              crossAxisCount: 3,
              children: generateCategoryItem(),
            ),
          ),
          Text(
            '每日推荐',
            style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
          ),
          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
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
