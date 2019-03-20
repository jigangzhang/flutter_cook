import 'package:cook/page/search_page.dart';
import 'package:flutter/material.dart';

class SnackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return SearchPage();
        }));
      },
      child: Container(
        padding: EdgeInsets.only(top: 5, left: 10, bottom: 5),
        child: Row(
          children: <Widget>[
            Icon(Icons.search),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text('search'),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.amberAccent,
            borderRadius: BorderRadius.all(Radius.circular(5))),
      ),
    );
  }
}
