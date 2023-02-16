import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // MethodChannelIosCommunicationNotification platform =
  //     MethodChannelIosCommunicationNotification();
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
}
