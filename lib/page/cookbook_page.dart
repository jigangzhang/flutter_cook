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

  @override
  void initState() {
    super.initState();
    _cookbook = widget.cookbook;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_cookbook.name),
      ),
      body: ListView(
        children: <Widget>[
          _cookbook.thumbnail == null
              ? null
              : Image.network(
                  _cookbook.recipe.img,
                  height: 200,
                  fit: BoxFit.fitWidth,
                ),
          Row(
            children: <Widget>[
              Text('标签：'),
              Text(_cookbook.ctgTitles),
            ],
          ),
          Text(_cookbook.recipe.sumary),
          Text('食材：'),
          Text(_cookbook.recipe.ingredients),
          Text('步骤：'),
          Text(_cookbook.recipe.method),
        ],
      ),
    );
  }
}