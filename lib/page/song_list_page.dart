import 'package:flutter/cupertino.dart';

import '../bean/index.dart';
import '../common/request_method.dart';
import 'player_page.dart';

class SongListPage extends StatefulWidget {
  static Future<T> start<T extends Object>(BuildContext context, {String disstid, String singermid, int topid}) {
    return Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(builder: (context) {
      // 要跳转的页面
      return SongListPage(disstid: disstid, singermid: singermid, topid: topid);
    }));
  }

  final String disstid;
  final String singermid;
  final int topid;

  SongListPage({Key key, this.disstid, this.singermid, this.topid}) : super(key: key);

  _SongListPageState createState() => _SongListPageState();
}

class _SongListPageState extends State<SongListPage> {
  final double _appBarHeight = 160.0;

  String title = '';
  String headerImage;
  List<SongData> songList = [];

  @override
  void initState() {
    super.initState();
    _requestData();
  }

  Future _requestData() async {
    if (widget.disstid != null) {
      RecommendSong res = await RequestApi.getRecommendSongList(widget.disstid);
      if (mounted) {
        setState(() {
          title = res.dissname;
          headerImage = res.logo;
          songList = res.songList;
        });
      }
    } else if (widget.singermid != null) {
      SingerSong res = await RequestApi.getSingerSongList(widget.singermid);
      if (mounted) {
        setState(() {
          title = res.singerName;
          headerImage = res.singerAvatar;
          songList = res.songList;
        });
      }
    } else if (widget.topid != null) {
      RankSong res = await RequestApi.getRankSongList(widget.topid);
      if (mounted) {
        setState(() {
          title = res.rankName;
          headerImage = res.rankImage;
          songList = res.songList;
        });
      }
    }
  }

  Widget _buildSongItem(int index) {
    final model = songList[index];
    return CupertinoButton(
      minSize: 0,
      pressedOpacity: 0.6,
      padding: EdgeInsets.all(0),
      borderRadius: BorderRadius.circular(0),
      onPressed: () {
        PlayerPage.start(context, model);
      },
      child: Container(
        height: 60,
        color: Color(0xFF202020),
        child: Row(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 20)),
            Image.network(model.image, width: 40),
            Padding(padding: EdgeInsets.only(left: 20)),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(model.songname, style: TextStyle(fontSize: 14, color: CupertinoColors.white), overflow: TextOverflow.ellipsis),
                  Padding(padding: EdgeInsets.only(top: 4)),
                  Text(model.singername, style: TextStyle(fontSize: 12, color: Color(0xFF909090)), overflow: TextOverflow.ellipsis, softWrap: false),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(height: _appBarHeight),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => _buildSongItem(index),
            childCount: songList.length,
          ),
        ),
      ],
    );
  }

  Widget _buildPageBody(BuildContext context) {
    return Column(
      children: <Widget>[
        // 标题
        CupertinoNavigationBar(
          backgroundColor: Color(0),
          previousPageTitle: '返回',
          middle: Text(title, style: TextStyle(fontSize: 16, color: Color(0xFFFFCD32))),
          border: Border.all(style: BorderStyle.none),
        ),
        Expanded(
          child: _buildList(context),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF202020),
      child: Stack(
        children: <Widget>[
          // 背景图
          headerImage == null ? Container() : Image.network(headerImage, fit: BoxFit.cover, width: 360),
          // PageBody
          _buildPageBody(context),
        ],
      ),
    );
  }
}
