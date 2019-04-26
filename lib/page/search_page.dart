import 'package:cook/entity/cook_bean.dart';
import 'package:cook/page/cookbook_page.dart';
import 'package:flutter/material.dart';
import 'package:cook/net/net.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchState();
  }
}

class SearchState extends State<SearchPage> {
  List<Cookbook> _cookbookList;
  bool _hasInput = false;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        automaticallyImplyLeading: false,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 12),
                padding:
                    EdgeInsets.only(left: 10, top: 6, right: 10, bottom: 6),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        onChanged: (text) {
                          setState(() {
                            _hasInput = text.length > 0;
                          });
                        },
                        onSubmitted: (text) {
                          getCookbookListByName(text, 1, (List<Cookbook> list) {
                            setState(() {
                              _cookbookList = list;
                            });
                          });
                        },
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                        decoration: InputDecoration.collapsed(
                          hintText: '请输入菜品名称',
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        cursorWidth: 2,
                        cursorRadius: Radius.circular(2),
                        cursorColor: Colors.orangeAccent,
                        textInputAction: TextInputAction.search,
                      ),
                    ),
                    _hasInput
                        ? InkWell(
                            child: Icon(
                              Icons.clear,
                              size: 18,
                            ),
                            onTap: () {
                              setState(() {
                                _controller.clear();
                                _hasInput = false;
                              });
                            },
                          )
                        : Container(
                            width: 0,
                            height: 0,
                          ),
                  ],
                ),
              ),
            ),
            InkWell(
              child: Text(
                '取消',
                style: TextStyle(fontSize: 16, color: Colors.orangeAccent),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      body: _cookbookList == null
          ? Center(
              child: Text('暂无搜索历史'),
            )
          : ListView.separated(
              padding: EdgeInsets.only(top: 15),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  child: Container(
                    padding: EdgeInsets.only(left: 20, top: 5, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _cookbookList[index].thumbnail == null
                            ? Image.asset(
                                'image/placeholder.png',
                                width: 45,
                                height: 45,
                              )
                            : FadeInImage.assetNetwork(
                                placeholder: 'image/placeholder.png',
                                image: _cookbookList[index].thumbnail,
                                height: 45,
                                width: 45,
                                fit: BoxFit.fill,
                              ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(_cookbookList[index].name),
                                Text(
                                  _cookbookList[index].ctgTitles,
                                  style: TextStyle(
                                      color: Colors.black45, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return CookbookPage(
                        cookbook: _cookbookList[index],
                      );
                    }));
                  },
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: _cookbookList.length),
    );
  }
}
