import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ios_communication_notification/ios_communication_notification_method_channel.dart';

void main() {
  MethodChannelIosCommunicationNotification platform = MethodChannelIosCommunicationNotification();
  const MethodChannel channel = MethodChannel('ios_communication_notification');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
