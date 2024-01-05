import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'external_path_provider_platform_interface.dart';

/// An implementation of [ExternalPathProviderPlatform] that uses method channels.
class MethodChannelExternalPathProvider extends ExternalPathProviderPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('external_path_provider');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
