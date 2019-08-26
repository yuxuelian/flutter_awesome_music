import 'package:flutter/cupertino.dart';

import 'home/mine_widget.dart';
import 'home/mini_controller_widget.dart';
import 'home/rank_widget.dart';
import 'home/recommend_widget.dart';
import 'home/singer_widget.dart';
import 'search_page.dart';

class HomePage extends StatefulWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _tabValues = [
    '推荐',
    '歌手',
    '排行',
    '我的',
  ];

  int _currentPage = 0;

  PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: _currentPage);
  }

  Widget _buildTabItem(BuildContext context, final value, final index) {
    Color borderColor = index == _currentPage ? Color(0xFFFFCD32) : Color(0);
    Color textColor = index == _currentPage ? Color(0xFFFFCD32) : Color(0xFF909090);
    return Expanded(
      child: CupertinoButton(
        minSize: 0,
        pressedOpacity: 0.6,
        padding: EdgeInsets.all(0),
        borderRadius: BorderRadius.circular(0),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 2, color: borderColor))),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: textColor,
            ),
          ),
        ),
        onPressed: () {
          _controller.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.linear);
        },
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Column(
      children: <Widget>[
        CupertinoNavigationBar(
          backgroundColor: Color(0),
          middle: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset('assets/logo.png', width: 26),
              Padding(padding: EdgeInsets.only(left: 10)),
              Text(
                'AwesomeMusic',
                style: TextStyle(fontSize: 16, color: Color(0xFFFFCD32)),
              ),
            ],
          ),
          trailing: CupertinoButton(
            minSize: 0,
            pressedOpacity: 0.6,
            padding: EdgeInsets.all(0),
            borderRadius: BorderRadius.circular(0),
            child: Image.asset('assets/search_btn.png', width: 25),
            onPressed: () {
              SearchPage.start(context);
            },
          ),
        ),
        Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: () {
              int index = 0;
              return _tabValues.map((value) => _buildTabItem(context, value, index++)).toList();
            }(),
          ),
        ),
        Expanded(
          child: PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                // 刷新页面
                _currentPage = index;
              });
            },
            children: <Widget>[
              RecommendPage(),
              SingerPage(),
              RankPage(),
              MinePage(),
            ],
          ),
        ),
        BottomMiniController(),
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
