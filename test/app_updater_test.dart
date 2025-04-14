import 'package:flutter_test/flutter_test.dart';
import 'package:app_updater/app_updater.dart';
import 'package:app_updater/app_updater_platform_interface.dart';
import 'package:app_updater/app_updater_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAppUpdaterPlatform
    with MockPlatformInterfaceMixin
    implements AppUpdaterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final AppUpdaterPlatform initialPlatform = AppUpdaterPlatform.instance;

  test('$MethodChannelAppUpdater is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAppUpdater>());
  });

}
