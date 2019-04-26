import 'package:cook/page/cookbook_page.dart';
import 'package:flutter/material.dart';
import 'package:cook/net/net.dart';
import 'package:cook/entity/cook_bean.dart';

///上拉加载
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
  ScrollController _controller = ScrollController();
  String _cid;
  List<Cookbook> _cookbooks = [];
  int _pageIndex = 1;
  int _state = 0; //0 初始状态， 1 还有下一页， 2 已完全加载
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _cid = widget.categoryId;
    generateData();
    _controller.addListener(() {
      if (!_isLoading && _state != 2) {
        var position = _controller.position;
        if (position.maxScrollExtent - position.pixels < 50) {
          _pageIndex = _pageIndex + 1;
          generateData();
          setState(() {
            _isLoading = true;
          });
        }
      }
    });
  }

  generateData() {
    getCookbookListByCid(_cid, _pageIndex, (CookbookList cookbookList) {
      setState(() {
        if (cookbookList.curPage * 20 < cookbookList.total)
          _state = 1;
        else
          _state = 2;
        _cookbooks.addAll(cookbookList.list);
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 3,
        iconTheme: IconThemeData(color: Colors.grey, size: 14),
        title: Text(
          widget.name,
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GridView.count(
//              semanticChildCount: _cookbooks.length + 1,
              shrinkWrap: true,
              controller: _controller,
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: EdgeInsets.only(top: 15, left: 8, right: 8),
              children: _cookbooks.map((cookbook) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return CookbookPage(
                        cookbook: cookbook,
                      );
                    }));
                  },
                  child: Column(
                    children: <Widget>[
                      cookbook.thumbnail == null
                          ? Image.asset('image/placeholder.png')
                          : FadeInImage.assetNetwork(
                              placeholder: 'image/placeholder.png',
                              image: cookbook.thumbnail,
                              fit: BoxFit.fill,
                            ),
                      Expanded(
                        child: Text(
                          cookbook.name,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          _isLoading
              ? Text('数据加载中...')
              : ( //_state == 2
                  //? Text('没有更多了')
                  /*:*/ Container(
                  height: 0,
                  width: 0,
                )),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
