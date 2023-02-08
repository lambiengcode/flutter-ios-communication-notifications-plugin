// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'package:ios_communication_notification/models/notification_info_model.dart';

import 'ios_communication_notification_platform_interface.dart';

class IosCommunicationNotification {
  Future<String?> getPlatformVersion() {
    return IosCommunicationNotificationPlatform.instance.getPlatformVersion();
  }

  Future<void> showNotification(NotificationInfo info) {
    return IosCommunicationNotificationPlatform.instance.showNotification(info);
  }

  Future<bool> isAvailable() {
    return IosCommunicationNotificationPlatform.instance.isAvailable();
  }

  void setOnClickNotification(Function(String payload) onClick) {
    return IosCommunicationNotificationPlatform.instance
        .onClickNotification(onClick);
  }
}
