import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

import '../bean/index.dart';

class PlayerPage extends StatefulWidget {
  static Future<T> start<T extends Object>(BuildContext context, SongData song) {
    return Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(builder: (context) {
      // 要跳转的页面
      return PlayerPage(song);
    }));
  }

  final SongData song;

  PlayerPage(this.song, {Key key}) : super(key: key);

  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> with TickerProviderStateMixin {
  double _currentValue = 25;

  AnimationController _imageController;
  CurvedAnimation _curved;

  AnimationController _widgetController;
  Animation<Offset> _topWidgetTween;
  Animation<Offset> _bottomWidgetTween;

  @override
  void initState() {
    super.initState();

    // 旋转动画
    _imageController = AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _curved = CurvedAnimation(parent: _imageController, curve: Curves.linear);
    _imageController.repeat();

    // widget进入动画
    _widgetController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _topWidgetTween = Tween(begin: Offset(0, -1.3), end: Offset.zero).animate(_widgetController);
    _bottomWidgetTween = Tween(begin: Offset(0, 1), end: Offset.zero).animate(_widgetController);

    // 延迟 400ms 启动进入动画
    Future.delayed(const Duration(milliseconds: 500), () {
      _widgetController.forward();
    });
  }

  @override
  void dispose() {
    _imageController.dispose();
    _widgetController.dispose();
    super.dispose();
  }

  // 返回键被点击
  void _onBackPressed() {
    if (mounted) {
      setState(() {
        // 重新限定动画执行返回
        _topWidgetTween = Tween(begin: Offset.zero, end: Offset(0, -1.3)).animate(_widgetController);
        _bottomWidgetTween = Tween(begin: Offset.zero, end: Offset(0, 1)).animate(_widgetController);

        // 启动动画
        _widgetController.reset();
        _widgetController.forward();

        // 添加状态监听回调
        _widgetController.addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            // 动画执行完毕,退出
            Navigator.of(context, rootNavigator: true).pop();
          }
        });
      });
    }
  }

  // 创建中间的歌曲图片Widget
  Widget _buildSongImage() {
    return SizedBox(
      width: 280,
      height: 280,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF909090),
              shape: BoxShape.circle,
            ),
          ),
          Center(
            child: RotationTransition(
              turns: _curved,
              child: SizedBox(
                width: 260,
                height: 260,
                child: ClipOval(
                  child: Image.network(widget.song.image),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMusicControl() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 20)),
            Text('00:00', style: TextStyle(fontSize: 12, color: CupertinoColors.white)),
            Expanded(
              child: CupertinoSlider(
                value: _currentValue,
                min: 0,
                max: 200,
                onChanged: (currentValue) {
                  if (mounted) {
                    setState(() {
                      _currentValue = currentValue;
                    });
                  }
                },
                onChangeEnd: (endValue) {
                  print(endValue);
                },
              ),
            ),
            Text('00:00', style: TextStyle(fontSize: 12, color: CupertinoColors.white)),
            Padding(padding: EdgeInsets.only(right: 20)),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 10)),
            CupertinoButton(
              minSize: 40,
              pressedOpacity: 0.6,
              padding: EdgeInsets.all(0),
              borderRadius: BorderRadius.circular(0),
              child: Image.asset('assets/single_song.png', width: 40),
              onPressed: () {},
            ),
            CupertinoButton(
              minSize: 40,
              pressedOpacity: 0.6,
              padding: EdgeInsets.all(0),
              borderRadius: BorderRadius.circular(0),
              child: Image.asset('assets/last_song.png', width: 40),
              onPressed: () {},
            ),
            CupertinoButton(
              minSize: 60,
              pressedOpacity: 0.6,
              padding: EdgeInsets.all(0),
              borderRadius: BorderRadius.circular(0),
              child: Image.asset('assets/big_play.png', width: 60),
              onPressed: () {},
            ),
            CupertinoButton(
              minSize: 40,
              pressedOpacity: 0.6,
              padding: EdgeInsets.all(0),
              borderRadius: BorderRadius.circular(0),
              child: Image.asset('assets/next_song.png', width: 40),
              onPressed: () {},
            ),
            CupertinoButton(
              minSize: 40,
              pressedOpacity: 0.6,
              padding: EdgeInsets.all(0),
              borderRadius: BorderRadius.circular(0),
              child: Image.asset('assets/conllection_normal.png', width: 40),
              onPressed: () {},
            ),
            Padding(padding: EdgeInsets.only(right: 10)),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 30)),
      ],
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 50)),
        Expanded(
          child: Center(
            child: Hero(
              tag: 'song_image',
              child: _buildSongImage(),
            ),
          ),
        ),
        Text('歌词', style: TextStyle(fontSize: 16, color: CupertinoColors.white)),
        Text('歌词', style: TextStyle(fontSize: 16, color: CupertinoColors.white)),
        Text('歌词', style: TextStyle(fontSize: 16, color: CupertinoColors.white)),
        Padding(padding: EdgeInsets.only(top: 10)),
        SlideTransition(
          position: _bottomWidgetTween,
          child: _buildMusicControl(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Stack(
        children: <Widget>[
          // 最下层背景图片
          ConstrainedBox(
            child: Image.network(widget.song.image, fit: BoxFit.fill),
            constraints: BoxConstraints.expand(),
          ),
          // 滤镜层(模糊背景)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: CupertinoPageScaffold(
              backgroundColor: Color(0x80000000),
              navigationBar: CupertinoNavigationBar(
                backgroundColor: Color(0),
                border: Border.all(style: BorderStyle.none),
                previousPageTitle: '返回',
                middle: SlideTransition(
                  position: _topWidgetTween,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(widget.song.songname, style: TextStyle(fontSize: 14, color: CupertinoColors.white)),
                      Text(widget.song.singername, style: TextStyle(fontSize: 12, color: CupertinoColors.white)),
                    ],
                  ),
                ),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints.expand(),
                child: _buildBody(),
              ),
            ),
          ),
        ],
      ),
      onWillPop: () {
        _onBackPressed();
        return Future.value(false);
      },
    );
  }
}
