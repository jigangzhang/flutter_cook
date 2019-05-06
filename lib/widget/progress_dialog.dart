import 'package:flutter/material.dart';

class NetLoadingDialog extends StatefulWidget {
  final String loadingText;
  final Function dismissCallback;
  final Future requestCallback;

  NetLoadingDialog(
      {Key key,
      this.loadingText = '数据加载中...',
      this.dismissCallback,
      this.requestCallback});

  @override
  State<StatefulWidget> createState() => _LoadingDialog();
}

class _LoadingDialog extends State<NetLoadingDialog> {
  _dismissDialog() {
    if (widget.dismissCallback != null) {
      widget.dismissCallback();
    }
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    if (widget.requestCallback != null) {
      widget.requestCallback.then((_) {
        _dismissDialog();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 100,
        width: 120,
        child: Container(
          decoration: ShapeDecoration(
              color: Colors.white30,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.amber[200]),
              ),
              Padding(
                padding: EdgeInsets.only(top: 12),
                child: Text(
                  widget.loadingText,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.amber[200],
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
