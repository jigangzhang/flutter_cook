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
  List<Cookbook> _cookbookList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: TextField(
          onSubmitted: (text) {
            getCookbookListByName(text, 1, (List<Cookbook> list) {
              setState(() {
                _cookbookList = list;
              });
            });
          },
          decoration: InputDecoration.collapsed(
            hintText: '请输入菜品名称',
          ),
          cursorWidth: 2,
          cursorColor: Colors.lightBlue,
          textInputAction: TextInputAction.search,
        ),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return InkWell(
              child: Text(_cookbookList[index].name),
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
