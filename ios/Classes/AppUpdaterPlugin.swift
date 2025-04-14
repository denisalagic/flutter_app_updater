import Flutter
import UIKit

public class AppUpdaterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "app_updater", binaryMessenger: registrar.messenger())
    let instance = AppUpdaterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
   switch call.method {
       case "getPlatformVersion":
         result("iOS " + UIDevice.current.systemVersion)
       case "getAppVersion":
         if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
           result(version)
         } else {
           result(FlutterError(code: "UNAVAILABLE", message: "App version not available", details: nil))
         }
       default:
         result(FlutterMethodNotImplemented)
     }
  }
}
