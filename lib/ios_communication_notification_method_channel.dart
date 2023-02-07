import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:ios_communication_notification/models/notification_info_model.dart';

import 'ios_communication_notification_platform_interface.dart';

/// An implementation of [IosCommunicationNotificationPlatform] that uses method channels.
class MethodChannelIosCommunicationNotification
    extends IosCommunicationNotificationPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ios_communication_notification');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> showNotification(NotificationInfo info) async {
    await methodChannel.invokeMethod("showNotification", info.toMap());
  }

  @override
  Future<bool> isAvailable() async {
    final bool result = await methodChannel.invokeMethod(
          "isAvailable",
        ) ??
        false;
    return result;
  }
}
