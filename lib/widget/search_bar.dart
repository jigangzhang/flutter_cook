import 'package:cook/page/search_page.dart';
import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return SearchPage();
        }));
      },
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.search,
              color: Colors.grey,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                '搜食谱',
                style: TextStyle(color: Colors.grey),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 1,
            ),
            color: Colors.grey[200],
            borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }
}
