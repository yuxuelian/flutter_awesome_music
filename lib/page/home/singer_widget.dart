import 'package:flutter/cupertino.dart';
import 'package:flutter_awesome_music/page/song_list_page.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../../bean/index.dart';
import '../../common/request_method.dart';

class SingerPage extends StatefulWidget {
  final Widget child;

  SingerPage({Key key, this.child}) : super(key: key);

  _SingerPageState createState() => _SingerPageState();
}

class _SingerPageState extends State<SingerPage> with AutomaticKeepAliveClientMixin {
  List<SingerGroup> _singerGroupList = [];

  double _itemHeight = 60;
  double _suspensionHeight = 30;

  ScrollController _controller;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _requestData();
    _controller = ScrollController();
  }

  Future _requestData() async {
    final singerGroupList = await RequestApi.getSingerList();
    if (mounted) {
      setState(() {
        _singerGroupList = singerGroupList;
      });
    }
  }

  Widget _buildSuspension(String susTag) {
    return Container(
      color: Color(0xFF303030),
      height: _suspensionHeight,
      padding: EdgeInsets.only(left: 20),
      alignment: Alignment.centerLeft,
      child: Text(
        susTag,
        style: TextStyle(fontSize: 12, color: Color(0xFF909090)),
      ),
    );
  }

  Widget _buildItem(Singer model) {
    return CupertinoButton(
      minSize: 0,
      pressedOpacity: 0.6,
      padding: EdgeInsets.all(0),
      borderRadius: BorderRadius.circular(0),
      onPressed: () {
        SongListPage.start(context, singermid: model.id);
      },
      child: Container(
        height: _itemHeight,
        child: Row(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 20)),
            ClipOval(child: Image.network(model.avatar, width: 40)),
            Padding(padding: EdgeInsets.only(left: 20)),
            Text(model.name, style: TextStyle(fontSize: 14, color: Color(0xFF909090))),
          ],
        ),
      ),
    );
  }

  Widget _buildIndexWidget(BuildContext context, final singerList, final index) {
    Color textColor = index == _currentIndex ? Color(0xFFFFCD32) : Color(0xFF909090);
    return CupertinoButton(
      minSize: 0,
      pressedOpacity: 0.6,
      padding: EdgeInsets.all(0),
      borderRadius: BorderRadius.circular(0),
      child: Container(
        width: double.infinity,
        height: 18,
        alignment: Alignment.center,
        child: Text(
          singerList.title.substring(0, 1),
          style: TextStyle(color: textColor, fontSize: 12),
        ),
      ),
      onPressed: () {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        Positioned(
          child: CustomScrollView(
            controller: _controller,
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => StickyHeader(
                    header: _buildSuspension(_singerGroupList[index].title),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: _singerGroupList[index].items.map((singer) => _buildItem(singer)).toList(),
                    ),
                  ),
                  childCount: _singerGroupList.length,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 26,
          padding: EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(color: CupertinoColors.black, borderRadius: BorderRadius.all(Radius.circular(13))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: () {
              int index = 0;
              return _singerGroupList.map((singerList) => _buildIndexWidget(context, singerList, index++)).toList();
            }(),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
