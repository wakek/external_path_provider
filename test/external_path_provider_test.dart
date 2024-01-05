import 'package:flutter_test/flutter_test.dart';
import 'package:external_path_provider/external_path_provider.dart';
import 'package:external_path_provider/external_path_provider_platform_interface.dart';
import 'package:external_path_provider/external_path_provider_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockExternalPathProviderPlatform
    with MockPlatformInterfaceMixin
    implements ExternalPathProviderPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ExternalPathProviderPlatform initialPlatform = ExternalPathProviderPlatform.instance;

  test('$MethodChannelExternalPathProvider is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelExternalPathProvider>());
  });

  test('getPlatformVersion', () async {
    ExternalPathProvider externalPathProviderPlugin = ExternalPathProvider();
    MockExternalPathProviderPlatform fakePlatform = MockExternalPathProviderPlatform();
    ExternalPathProviderPlatform.instance = fakePlatform;

    expect(await externalPathProviderPlugin.getPlatformVersion(), '42');
  });
}
