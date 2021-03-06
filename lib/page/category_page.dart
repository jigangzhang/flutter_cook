import 'package:cook/entity/cook_bean.dart';
import 'package:cook/page/cook_list_page.dart';
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
        elevation: 3,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.grey, size: 14),
        title: Text(
          '分类',
          style: TextStyle(fontSize: 16),
        ),
        bottom: TabBar(
            unselectedLabelColor: Colors.grey,
            unselectedLabelStyle: TextStyle(fontSize: 14),
            labelColor: Colors.black87,
            labelStyle: TextStyle(fontSize: 15),
            indicatorColor: Colors.orangeAccent,
            indicatorWeight: 3,
            indicatorSize: TabBarIndicatorSize.label,
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
            padding: EdgeInsets.only(top: 0),
            children: ListTile.divideTiles(
              context: context,
              color: Colors.grey,
              tiles: category.childs.map(
                (item) {
                  return Container(
                    color: Colors.white,
                    height: 60,
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return CookListPage(
                              item.categoryInfo.ctgId, item.categoryInfo.name);
                        }));
                      },
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              item.categoryInfo.name,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black87),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black12,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ).toList(),
          );
        }).toList(),
      ),
    );
  }
}
