import 'package:flutter/cupertino.dart';

class MinePage extends StatefulWidget {
  final Widget child;

  MinePage({Key key, this.child}) : super(key: key);

  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      alignment: Alignment.center,
      child: Text('我的'),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
