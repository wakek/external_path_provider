package com.wakek.external_path_provider


import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import android.content.Context
import java.io.File
import kotlin.collections.ArrayList

/** ExternalPathProviderPlugin */
class ExternalPathProviderPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
    private lateinit var channel : MethodChannel
    private lateinit var context: Context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "external_path_provider")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
        "getPlatformVersion" -> {
          result.success("Android ${android.os.Build.VERSION.RELEASE}")
        }
        "getExternalStorageDirectories" -> {
          result.success(getExternalStorageDirectories())
        }
        "getExternalStoragePublicDirectory" -> {
          result.success(getExternalStoragePublicDirectory(call.argument<String>("type")))
        }
        else -> {
          result.notImplemented()
        }
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }


  fun getExternalStorageDirectories() : ArrayList<String> {
    val appsDir: Array<File> = context.getExternalFilesDirs(null)
    var extRootPaths: ArrayList<String> = ArrayList<String>()
    for (file: File in appsDir)
      extRootPaths.add(file.getAbsolutePath())
    return extRootPaths;
    // return Environment.getExternalStorageDirectory().toString();
  }

  fun getExternalStoragePublicDirectory(type: String?) : String {
    return context.getExternalFilesDir(type).toString()
  }
}























