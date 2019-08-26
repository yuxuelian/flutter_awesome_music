import 'package:flutter/cupertino.dart';

class SearchPage extends StatelessWidget {
  static Future<T> start<T extends Object>(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(builder: (context) {
      // 要跳转的页面
      return SearchPage();
    }));
  }

  SearchPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Color(0xFF202020),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Color(0),
        previousPageTitle: '返回',
        middle: Text('搜索', style: TextStyle(fontSize: 16, color: Color(0xFFFFCD32))),
        border: Border.all(style: BorderStyle.none),
      ),
      child: Container(
        child: Center(
          child: Text('搜索页', style: TextStyle(fontSize: 20, color: CupertinoColors.white)),
        ),
      ),
    );
  }
}
