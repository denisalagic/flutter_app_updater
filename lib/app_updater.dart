import 'dart:async';
import 'package:flutter/services.dart';

class AppUpdater {
  static const MethodChannel _channel = MethodChannel('app_updater');

  static Future<String?> getPlatformVersion() async {
    return await _channel.invokeMethod('getPlatformVersion');
  }

  static Future<String?> getAppVersion() async {
    return await _channel.invokeMethod('getAppVersion');
  }
}
