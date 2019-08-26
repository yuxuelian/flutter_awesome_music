import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_awesome_music/page/song_list_page.dart';
import 'package:flutter_common_plugin/flutter_common_plugin.dart';

import '../../bean/index.dart';
import '../../common/request_method.dart';

class RecommendPage extends StatefulWidget {
  final Widget child;

  RecommendPage({Key key, this.child}) : super(key: key);

  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> with AutomaticKeepAliveClientMixin {
  List<RecommendData> recommendDataList = [];
  List<BannerData> bannerDataList = [];

  @override
  bool get wantKeepAlive => true;

  String _batteryLevel = '';

  Future _getBatteryLevel() async {
    String batteryLevel;
    try {
      batteryLevel = '当前手机电量: ${await FlutterCommonPlugin.batteryLevel} % .';
    } on PlatformException catch (e) {
      batteryLevel = '获取手机电量失败';
    }

    if (mounted) {
      setState(() {
        _batteryLevel = batteryLevel;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // 获取数据
    _requestData();

    // 获取电池电量
    _getBatteryLevel();
  }

  Future _requestData() async {
    final _bannerData = await RequestApi.getBannerList();
    final _recommendData = await RequestApi.getRecommendList();
    if (mounted) {
      setState(() {
        recommendDataList = _recommendData;
        bannerDataList = _bannerData;
      });
    }
  }

  Widget _buildList(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
            height: 144,
            width: 360,
            child: Swiper(
              itemBuilder: (context, index) {
                return Image.network(bannerDataList[index].picUrl);
              },
              itemCount: bannerDataList.length,
              // 指示器
              pagination: SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                  activeColor: Color(0xFFFFCD32),
                  color: Color(0xFF202020),
                ),
              ),
              // 不显示按钮
              // control: SwiperControl(),
              autoplay: true,
              autoplayDelay: 5000,
              duration: 1000,
              loop: true,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 40,
            alignment: Alignment.center,
            child: Text(_batteryLevel, style: TextStyle(color: Color(0xFFFFCD32), fontSize: 16)),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return _RecommendItem(recommendData: recommendDataList[index]);
          }, childCount: recommendDataList.length),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _buildList(context);
  }
}

// ignore: must_be_immutable
class _RecommendItem extends StatelessWidget {
  RecommendData recommendData;

  _RecommendItem({Key key, this.recommendData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: 0,
      pressedOpacity: 0.6,
      padding: EdgeInsets.all(0),
      borderRadius: BorderRadius.circular(0),
      onPressed: () {
        SongListPage.start(context, disstid: recommendData.disstid);
      },
      child: Container(
        height: 70,
        child: Row(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 20)),
            Image.network(recommendData.imgurl, width: 50),
            Padding(padding: EdgeInsets.only(left: 20)),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(recommendData.name, style: TextStyle(fontSize: 14, color: CupertinoColors.white)),
                Padding(padding: EdgeInsets.only(top: 12)),
                Text(recommendData.name, style: TextStyle(fontSize: 14, color: Color(0xFF909090))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
