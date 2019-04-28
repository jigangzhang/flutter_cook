import 'package:cook/entity/cook_bean.dart';
import 'package:cook/page/category_page.dart';
import 'package:cook/widget/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:cook/net/net.dart';
import 'package:cook/page/cook_list_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'cookbook',
      theme: ThemeData(
        primaryColor: Colors.white,
        backgroundColor: Colors.white,
        accentColor: Colors.white,
      ),
      home: MyHomePage(title: 'cookbook'),
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
            } else {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return CookListPage(null, '我的收藏');
              }));
            }
          },
          child: Container(
            child: Center(
              child: Text(
                index < _category.length
                    ? _category[index].categoryInfo.name.substring(1, 3)
                    : '我的收藏',
                style: TextStyle(color: Colors.black87, fontSize: 14),
              ),
            ),
            decoration: BoxDecoration(
                border: Border.all(
                    style: BorderStyle.solid,
                    width: 1,
                    color: Colors.grey[300]),
                shape: BoxShape.rectangle),
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
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SearchButton(),
            Padding(
              padding: EdgeInsets.only(left: 12, top: 8),
              child: Text(
                '分类',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                childAspectRatio: 2.5,
                crossAxisCount: 3,
                children: generateCategoryItem(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12, top: 4),
              child: Text(
                '每日推荐',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
            ),
          ],
        ),
      ),
//      bottomNavigationBar: BottomNavigationBar(
//        items: [
//          BottomNavigationBarItem(
//              icon: Icon(Icons.home),
//              title: Text('home'),
//              backgroundColor: Colors.lightGreenAccent),
//          BottomNavigationBarItem(
//              icon: Icon(
//                Icons.add_alert,
//              ),
//              title: Text(
//                'center',
//                style: TextStyle(color: Colors.amberAccent),
//              ),
//              backgroundColor: Colors.cyan),
//        ],
//        currentIndex: _currentIndex,
//        onTap: (index) {
//          setState(() {
//            _currentIndex = index;
//          });
//        },
//        type: BottomNavigationBarType.shifting,
//        fixedColor: Colors.lightGreenAccent,
//        iconSize: 25,
//      ),
//      drawer: Container(
//        child: Drawer(
//          elevation: 5,
//          child: ListView(
//            children: <Widget>[
//              ListTile(
//                title: Text('center'),
//              )
//            ],
//          ),
//        ),
//        width: 240,
//      ),
    );
  }
}
