import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:external_path_provider/external_path_provider_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelExternalPathProvider platform = MethodChannelExternalPathProvider();
  const MethodChannel channel = MethodChannel('external_path_provider');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
