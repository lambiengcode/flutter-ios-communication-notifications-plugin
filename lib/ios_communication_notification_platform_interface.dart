import 'package:ios_communication_notification/models/notification_info_model.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ios_communication_notification_method_channel.dart';

abstract class IosCommunicationNotificationPlatform extends PlatformInterface {
  /// Constructs a IosCommunicationNotificationPlatform.
  IosCommunicationNotificationPlatform() : super(token: _token);

  static final Object _token = Object();

  static IosCommunicationNotificationPlatform _instance =
      MethodChannelIosCommunicationNotification();

  /// The default instance of [IosCommunicationNotificationPlatform] to use.
  ///
  /// Defaults to [MethodChannelIosCommunicationNotification].
  static IosCommunicationNotificationPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [IosCommunicationNotificationPlatform] when
  /// they register themselves.
  static set instance(IosCommunicationNotificationPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> showNotification(NotificationInfo info) {
    throw UnimplementedError('showNotification() has not been implemented.');
  }
}
