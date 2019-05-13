import 'package:cook/page/cookbook_page.dart';
import 'package:cook/widget/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:cook/net/net.dart';
import 'package:cook/entity/cook_bean.dart';
import 'package:cook/database/database_sqflite.dart';

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
    if (_cid != null) _show();
  }

  _show() async {
    await Future.delayed(Duration(milliseconds: 100));
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return NetLoadingDialog(
          dismissCallback: () {},
          requestCallback: _getCookbookList(),
        );
      },
    );
  }

  generateData() {
    if (_cid == null) {
      DatabaseHelper().queryAll(DatabaseHelper.TYPE_COLLECT).then((list) {
        setState(() {
          _state = 2;
          list.forEach((map) {
            _cookbooks.add(Cookbook.fromMap(map));
          });
        });
      });
    } else {
      _getCookbookList();
    }
  }

  Future<int> _getCookbookList() async {
    await getCookbookListByCid(
      (CookbookList cookbookList) {
        setState(() {
          if (cookbookList.curPage * 20 < cookbookList.total)
            _state = 1;
          else
            _state = 2;
          _cookbooks.addAll(cookbookList.list);
          _isLoading = false;
        });
      },
      cid: _cid,
      page: _pageIndex,
    );
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.grey, size: 14),
        title: Text(
          widget.name,
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: _cid == null && _cookbooks.length == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'image/no-data.png',
                    height: 100,
                    width: 100,
                  ),
                  Text(
                    '暂无收藏记录',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  )
                ],
              ),
            )
          : Column(
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
