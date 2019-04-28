import 'package:cook/entity/cook_bean.dart';
import 'package:flutter/material.dart';
import 'package:cook/net/net.dart';
import 'package:cook/database/database_sqflite.dart';

class CookbookPage extends StatefulWidget {
  final Cookbook cookbook;
  final bool needQuery;

  CookbookPage({Key key, @required this.cookbook, this.needQuery = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CookbookState();
  }
}

class CookbookState extends State<CookbookPage> {
  Cookbook _cookbook;
  DatabaseHelper _dBHelper;
  String _ingredient = '';
  bool _isCollected = false;

  @override
  void initState() {
    super.initState();
    _cookbook = widget.cookbook;
    print('page -- ${_cookbook.toString()}');
    if (widget.needQuery || _cookbook.recipe == null) {
      getCookbook(_cookbook.menuId, (cookbook) {
        setState(() {
          _cookbook = cookbook;
          if (_cookbook.recipe != null)
            _cookbook.recipe.ingredient.forEach((item) {
              _ingredient = _ingredient + item;
            });
        });
      });
    } else if (_cookbook.recipe != null)
      _cookbook.recipe.ingredient.forEach((item) {
        _ingredient = _ingredient + item;
      });
    _dBHelper = DatabaseHelper();
    _dBHelper
        .queryCookbook(_cookbook.menuId, DatabaseHelper.TYPE_COLLECT)
        .then((list) {
      setState(() {
        _isCollected = list != null && list.length > 0;
      });
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
              if (_isCollected)
                _dBHelper
                    .deleteCookbook(
                        _cookbook.menuId, DatabaseHelper.TYPE_COLLECT)
                    .then((result) {
                  setState(() {
                    _isCollected = false;
                  });
                });
              else
                _dBHelper.collectCookbook(_cookbook).then((result) {
                  setState(() {
                    _isCollected = result > 0;
                  });
                });
            },
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 15),
              child: Center(
                child: Text(
                  _isCollected ? '已收藏' : '收藏',
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
      body: _cookbook.recipe == null
          ? Container()
          : ListView(
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
