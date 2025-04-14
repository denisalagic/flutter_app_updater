import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'app_updater_platform_interface.dart';

/// An implementation of [AppUpdaterPlatform] that uses method channels.
class MethodChannelAppUpdater extends AppUpdaterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('app_updater');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
