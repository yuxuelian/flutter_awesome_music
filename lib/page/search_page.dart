import 'package:flutter/cupertino.dart';

class SearchPage extends StatelessWidget {
  static Future<T> start<T extends Object>(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(builder: (context) {
      // 要跳转的页面
      return SearchPage();
    }));
  }

  SearchPage({Key key}) : super(key: key);

  Widget _buildPage(BuildContext context) {
    return Column(
      children: <Widget>[
        CupertinoNavigationBar(
          backgroundColor: Color(0),
          previousPageTitle: '返回',
          middle: Text('搜索', style: TextStyle(fontSize: 16, color: Color(0xFFFFCD32))),
          border: Border.all(style: BorderStyle.none),
        ),
        Container(
          color: CupertinoColors.activeGreen,
          child: CupertinoTextField(
            placeholder: '测试',
            textInputAction: TextInputAction.send,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF202020),
      child: _buildPage(context),
    );
  }
}
