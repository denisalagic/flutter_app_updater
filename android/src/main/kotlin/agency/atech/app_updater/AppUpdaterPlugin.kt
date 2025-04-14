package agency.atech.app_updater

import android.content.Intent
import android.net.Uri
import android.os.Build
import android.text.TextUtils
import androidx.annotation.NonNull
import androidx.core.content.FileProvider
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.File

/** AppUpdaterPlugin */
class AppUpdaterPlugin : FlutterPlugin, MethodCallHandler {
  private lateinit var channel: MethodChannel
  private lateinit var binding: FlutterPlugin.FlutterPluginBinding

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    binding = flutterPluginBinding
    channel = MethodChannel(binding.binaryMessenger, "app_updater")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "getPlatformVersion" -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      "getAppVersion" -> {
        try {
          val context = binding.applicationContext
          val pInfo = context.packageManager.getPackageInfo(context.packageName, 0)
          val version = pInfo.versionName
          result.success(version)
        } catch (e: Exception) {
          result.error("UNAVAILABLE", "App version not available", null)
        }
      }
      "installApk" -> {
        val apkPath: String? = call.argument("apkPath")
        if (!apkPath.isNullOrEmpty()) {
          installApk(File(apkPath), result)
        } else {
          result.error("installApk", "apkPath is null or empty", null)
        }
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  private fun installApk(apkFile: File, result: Result) {
    val context = binding.applicationContext
    if (apkFile.exists() && apkFile.length() > 0) {
      val intent = Intent(Intent.ACTION_VIEW).apply {
        addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
          addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
          val contentUri = FileProvider.getUriForFile(
            context,
            "${context.packageName}.fileProvider",
            apkFile
          )
          setDataAndType(contentUri, "application/vnd.android.package-archive")
        } else {
          setDataAndType(Uri.fromFile(apkFile), "application/vnd.android.package-archive")
        }
      }
      context.startActivity(intent)
      result.success(true)
    } else {
      result.success(false)
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}

