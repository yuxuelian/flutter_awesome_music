import 'package:flutter/cupertino.dart';
import 'package:flutter_awesome_music/page/song_list_page.dart';

import '../../bean/index.dart';
import '../../common/request_method.dart';

class RankPage extends StatefulWidget {
  final Widget child;

  RankPage({Key key, this.child}) : super(key: key);

  _RankPageState createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> with AutomaticKeepAliveClientMixin {
  List<RankTop> rankTopList = [];

  @override
  void initState() {
    super.initState();
    _requestData();
  }

  Future _requestData() async {
    final res = await RequestApi.getRankList();
    if (mounted) {
      setState(() {
        rankTopList = res;
      });
    }
  }

  Widget _buildListItem(int index) {
    final model = rankTopList[index];
    var num = 0;
    List<Widget> songWidgets = model.songList.map((song) {
      num++;
      return Text('$num.${song.songname} - ${song.singername}', style: TextStyle(fontSize: 16, color: Color(0xFF909090)), overflow: TextOverflow.ellipsis);
    }).toList();
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: CupertinoButton(
        minSize: 0,
        pressedOpacity: 0.6,
        padding: EdgeInsets.all(0),
        borderRadius: BorderRadius.circular(0),
        onPressed: () {
          SongListPage.start(context, topid: model.id);
        },
        child: Container(
          height: 80,
          child: Row(
            children: <Widget>[
              Container(
                width: 80,
                height: 80,
                child: Image.network(model.picUrl),
              ),
              Padding(padding: EdgeInsets.only(left: 20)),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: songWidgets,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => _buildListItem(index),
            childCount: rankTopList.length,
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
