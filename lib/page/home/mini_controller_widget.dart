import 'package:flutter/cupertino.dart';

import '../../bean/index.dart';
import '../player_page.dart';

class BottomMiniController extends StatefulWidget {
  final Widget child;

  BottomMiniController({Key key, this.child}) : super(key: key);

  _BottomMiniControllerState createState() => _BottomMiniControllerState();
}

class _BottomMiniControllerState extends State<BottomMiniController> with TickerProviderStateMixin {
  SongData _songData;

  AnimationController _imageController;
  CurvedAnimation _curved;

  @override
  void initState() {
    super.initState();

    // 旋转动画
    _imageController = AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _curved = CurvedAnimation(parent: _imageController, curve: Curves.linear);
    _imageController.repeat();

    // TODO 模拟数据
    _songData = SongData.fromParams(
      songmid: '004Xb74H2gNmDf',
      image: 'https://y.gtimg.cn/music/photo_new/T002R300x300M000003Np6Y74ctROu.jpg?max_age=2592000',
      singername: '跟风超人',
      songname: '你打不过我吧 (Live)',
      url:
          'http://182.140.219.30/amobile.music.tc.qq.com/C400004Xb74H2gNmDf.m4a?guid=4715368380&vkey=D1E53F14F53712B25906B0AC88EE12B93CBBC51374FD78EF91F75A5603ACEA44D358E06323EB1056FB2EFCF444B64819AFCFFB1E000B9B62&uin=0&fromtag=999',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(left: 20)),
          RotationTransition(
            turns: _curved,
            child: Hero(
              tag: 'song_image',
              child: ClipOval(
                child: _songData == null ? Image.asset('assets/logo.png', width: 36) : Image.network(_songData.image, width: 36),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(left: 10)),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(_songData.songname, style: TextStyle(fontSize: 14, color: CupertinoColors.white)),
                Text(_songData.singername, style: TextStyle(fontSize: 12, color: Color(0xFF909090))),
              ],
            ),
          ),
          CupertinoButton(
            minSize: 0,
            pressedOpacity: 0.6,
            padding: EdgeInsets.all(0),
            borderRadius: BorderRadius.circular(0),
            onPressed: () {
              // 跳转
              PlayerPage.start(context, _songData);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: Image.asset('assets/play.png'),
            ),
          ),
          CupertinoButton(
            minSize: 0,
            pressedOpacity: 0.6,
            padding: EdgeInsets.all(0),
            borderRadius: BorderRadius.circular(0),
            onPressed: () {
              print('列表');
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: Image.asset('assets/music_list.png'),
            ),
          ),
        ],
      ),
    );
  }
}
