
import 'app_updater_platform_interface.dart';

class AppUpdater {
  Future<String?> getPlatformVersion() {
    return AppUpdaterPlatform.instance.getPlatformVersion();
  }
}
