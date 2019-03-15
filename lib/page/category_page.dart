import 'package:cook/entity/cook_bean.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  final List<CategoryInfo> list;
  final int index;

  CategoryPage({Key key, @required this.list, @required this.index})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CategoryState();
  }
}

class CategoryState extends State<CategoryPage> with TickerProviderStateMixin {
  List<CategoryInfo> _categoryList;
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _categoryList = widget.list;
  }

  @override
  Widget build(BuildContext context) {
    _controller = TabController(
        length: _categoryList.length, vsync: this, initialIndex: widget.index);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('分类'),
        bottom: TabBar(
            controller: _controller,
            isScrollable: true,
            tabs: _categoryList.map((category) {
              return Tab(text: category.categoryInfo.name);
            }).toList()),
      ),
      body: TabBarView(
        controller: _controller,
        children: _categoryList.map((category) {
          return ListView(
              children: category.childs.map((item) {
            return Container(
                height: 40,
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(item.categoryInfo.name),
                    Icon(Icons.arrow_forward)
                  ],
                )));
          }).toList());
        }).toList(),
      ),
    );
  }
}
