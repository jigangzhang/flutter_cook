import 'package:cook/page/cookbook_page.dart';
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
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: EdgeInsets.only(top: 15, left: 5, right: 5),
        children: _cookbooks.map((cookbook) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return CookbookPage(
                  cookbook: cookbook,
                );
              }));
            },
            child: Column(
              children: <Widget>[
                cookbook.thumbnail == null
                    ? Image.asset('image/placeholder.png')
                    : Image.network(
                        cookbook.thumbnail,
                        fit: BoxFit.fill,
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
