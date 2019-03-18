import 'package:flutter/material.dart';
import 'package:cook/net/net.dart';
import 'package:cook/entity/cook_bean.dart';

class CookListPage extends StatefulWidget {
  final String categoryId;
  final String name;

  CookListPage(this.categoryId, this.name);

  @override
  State<StatefulWidget> createState() {
    return CookListState();
  }
}

class CookListState extends State<CookListPage> {
  String _cid;
  List<Cookbook> _cookbooks = [];

  @override
  void initState() {
    super.initState();
    _cid = widget.categoryId;
    getCookbookListByCid(_cid, 1, (CookbookList cookbookList) {
      setState(() {
        _cookbooks = cookbookList.list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: _cookbooks.map((cookbook) {
          return InkWell(
            child: Column(
              children: <Widget>[
                Image.network(
                  cookbook.thumbnail,
                ),
                Text(cookbook.name)
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
