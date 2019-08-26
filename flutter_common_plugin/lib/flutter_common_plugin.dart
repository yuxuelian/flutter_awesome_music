import 'dart:async';

import 'package:flutter/services.dart';

class FlutterCommonPlugin {
  static const MethodChannel _channel = const MethodChannel('flutter_common_plugin');

  /// 获取手机平台及版本
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// 获取手机电量
  static Future<int> get batteryLevel async {
    final int level = await _channel.invokeMethod('getBatteryLevel');
    return level;
  }

  /// 设置 状态栏沉浸式
  static Future<void> immersive(bool isLight) async {
    await _channel.invokeMethod('immersive', {'isLight': isLight});
  }

  /// 固定屏幕方向为纵向
  static Future<void> fixedScreenVertical() async {
    await _channel.invokeMethod('fixedScreenVertical');
  }
}
