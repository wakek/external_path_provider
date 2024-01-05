import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'external_path_provider_method_channel.dart';

abstract class ExternalPathProviderPlatform extends PlatformInterface {
  /// Constructs a ExternalPathProviderPlatform.
  ExternalPathProviderPlatform() : super(token: _token);

  static final Object _token = Object();

  static ExternalPathProviderPlatform _instance = MethodChannelExternalPathProvider();

  /// The default instance of [ExternalPathProviderPlatform] to use.
  ///
  /// Defaults to [MethodChannelExternalPathProvider].
  static ExternalPathProviderPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ExternalPathProviderPlatform] when
  /// they register themselves.
  static set instance(ExternalPathProviderPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
