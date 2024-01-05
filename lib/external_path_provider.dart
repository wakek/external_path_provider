import 'dart:async';

import 'package:flutter/services.dart';

import 'external_path_provider_platform_interface.dart';

class ExternalPathProvider {
  static const MethodChannel _channel = MethodChannel('external_path_provider');

  static const String DIRECTORY_MUSIC = "Music";
  static const String DIRECTORY_PODCASTS = "Podcasts";
  static const String DIRECTORY_RINGTONES = "Ringtones";
  static const String DIRECTORY_ALARMS = "Alarms";
  static const String DIRECTORY_NOTIFICATIONS = "Notifications";
  static const String DIRECTORY_PICTURES = "Pictures";
  static const String DIRECTORY_MOVIES = "Movies";
  static const String DIRECTORY_DOWNLOADS = "Download";
  static const String DIRECTORY_DCIM = "DCIM";
  static const String DIRECTORY_DOCUMENTS = "Documents";
  static const String DIRECTORY_SCREENSHOTS = "Screenshots";
  static const String DIRECTORY_AUDIOBOOKS = "Audiobooks";

  Future<String?> getPlatformVersion() {
    return ExternalPathProviderPlatform.instance.getPlatformVersion();
  }

  static Future<List<String>> getExternalStorageDirectories() async {
    final List externalStorageDirectories =
        await _channel.invokeMethod('getExternalStorageDirectories');

    List<String> storageInfo = externalStorageDirectories
        .map((storageInfoMap) => ExStoragePath01.getRootDir(storageInfoMap))
        .toList();
    return storageInfo;
  }

  static Future<String> getExternalStoragePublicDirectory(String type) async {
    final String externalPublicDir = await _channel
        .invokeMethod('getExternalStoragePublicDirectory', {'type': type});
    return externalPublicDir;
  }
}

class ExStoragePath01 {
  static String getRootDir(String appFilesDir) {
    return appFilesDir
        .split("/")
        .sublist(0, appFilesDir.split("/").length - 4)
        .join("/");
  }
}
