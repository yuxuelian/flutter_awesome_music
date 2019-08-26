import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_common_plugin/flutter_common_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  int _batteryLevel = -1;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    int batteryLevel;
    try {
      platformVersion = await FlutterCommonPlugin.platformVersion;
      batteryLevel = await FlutterCommonPlugin.batteryLevel;
      await FlutterCommonPlugin.immersive(false);
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
      batteryLevel = -1;
    }
    if (!mounted) return;
    setState(() {
      _platformVersion = platformVersion;
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('插件测试'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('平台版本: $_platformVersion'),
              Text('电池电量: $_batteryLevel%'),
            ],
          ),
        ),
      ),
    );
  }
}
