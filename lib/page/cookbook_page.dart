import 'package:cook/entity/cook_bean.dart';
import 'package:flutter/material.dart';

class CookbookPage extends StatefulWidget {
  final Cookbook cookbook;

  CookbookPage({Key key, @required this.cookbook}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CookbookState();
  }
}

class CookbookState extends State<CookbookPage> {
  Cookbook _cookbook;
  String _ingredient = '';

  @override
  void initState() {
    super.initState();
    _cookbook = widget.cookbook;
    _cookbook.recipe.ingredient.forEach((item) {
      _ingredient = _ingredient + item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        actions: <Widget>[
          InkWell(
            onTap: () {
              print('click...');
            },
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 15),
              child: Center(
                child: Text(
                  '收藏',
                  style: TextStyle(fontSize: 16, color: Colors.orangeAccent),
                ),
              ),
            ),
          )
        ],
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.grey, size: 14),
        title: Text(
          _cookbook.name,
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          _cookbook.recipe.img == null
              ? Container(
                  margin: EdgeInsets.only(top: 5),
                  width: 0,
                  height: 0,
                )
              : Container(
                  margin: EdgeInsets.only(top: 5, bottom: 10),
                  child: FadeInImage.assetNetwork(
                      height: 200,
                      fit: BoxFit.cover,
                      placeholder: 'image/placeholder.png',
                      image: _cookbook.recipe.img),
                ),
          Row(
            children: <Widget>[
              Text(
                '标签：',
                style: TextStyle(color: Colors.orangeAccent),
              ),
              Text(
                '${_cookbook.ctgTitles}',
                style: TextStyle(color: Colors.orangeAccent),
              ),
            ],
          ),
          (_cookbook.recipe.sumary != null &&
                  _cookbook.recipe.sumary.length > 0)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('简介：'),
                    Text(
                      '    ${_cookbook.recipe.sumary}',
                      style: TextStyle(color: Colors.black87),
                    )
                  ],
                )
              : Container(
                  height: 0,
                  width: 0,
                ),
          _cookbook.recipe.ingredient.length > 0
              ? Text('食材：')
              : Container(
                  height: 0,
                  width: 0,
                ),
          Text("$_ingredient"),
          Text(''),
          generateMethod(),
        ],
      ),
    );
  }

  generateMethod() {
    if (_cookbook.recipe.method.length > 0) {
      var _list = [];
      _list.add(Text('制作步骤：'));
      _cookbook.recipe.cookMethods.forEach((method) {
        if (method.img != null) {
          _list.add(FadeInImage.assetNetwork(
            placeholder: 'image/placeholder.png',
            image: method.img,
            fit: BoxFit.none,
          ));
        }
        if (method.step != null) {
          _list.add(Text(method.step));
        }
      });
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _list.length,
        itemBuilder: (context, index) {
          return _list[index];
        },
      );
    } else
      return Container(
        width: 0,
        height: 0,
      );
  }
}
