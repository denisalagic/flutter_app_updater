import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'app_updater_method_channel.dart';

abstract class AppUpdaterPlatform extends PlatformInterface {
  /// Constructs a AppUpdaterPlatform.
  AppUpdaterPlatform() : super(token: _token);

  static final Object _token = Object();

  static AppUpdaterPlatform _instance = MethodChannelAppUpdater();

  /// The default instance of [AppUpdaterPlatform] to use.
  ///
  /// Defaults to [MethodChannelAppUpdater].
  static AppUpdaterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AppUpdaterPlatform] when
  /// they register themselves.
  static set instance(AppUpdaterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
