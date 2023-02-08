import Flutter
import UIKit

public class IosCommunicationConstant {
    static let prefixIdentifier: String = "CommunicationNotification"
}

public class IosCommunicationNotificationPlugin: NSObject, FlutterPlugin {
    var flutterChannel: FlutterMethodChannel?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "ios_communication_notification", binaryMessenger: registrar.messenger())
        let instance = IosCommunicationNotificationPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        self.flutterChannel = channel
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch (call.method) {
        case "showNotification":
            let arguments = call.arguments as? [String: Any] ?? [String: Any]()
            let senderName = arguments["senderName"] as? String ?? ""
            let content = arguments["content"] as? String ?? ""
            guard let avatar = (arguments["imageBytes"] as? FlutterStandardTypedData)?.data else {
                result(false)
                return
            }
            let value = arguments["value"] as? String ?? ""
            CommunicationNotificationPlugin().showNotification(NotificationInfo(senderName: senderName, pngImage: avatar, content: content, value: value))
            result(true)
            break
        case "isAvailable":
            if #available(iOS 15.0, *) {
                result(true)
            } else {
                result(false)
            }
            break
        default:
            result(FlutterMethodNotImplemented)
            break
        }
    }
}

extension IosCommunicationNotificationPlugin: UNUserNotificationCenterDelegate {
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if #available(iOS 15.0, *) {
            if (notification.request.identifier.starts(with: IosCommunicationConstant.prefixIdentifier)) {
                completionHandler([.banner, .badge, .sound])
            }
        }
        
        return userNotificationCenter(center, willPresent: notification, withCompletionHandler: completionHandler)
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if #available(iOS 15.0, *) {
            if (response.notification.request.identifier.starts(with: IosCommunicationConstant.prefixIdentifier)) {
                let userInfo = response.notification.request.content.userInfo
                
                self.flutterChannel?.invokeMethod("onClick", arguments: userInfo)
                
                completionHandler()
            }
        }
        
        return userNotificationCenter(center, didReceive: response, withCompletionHandler: completionHandler)
    }
}
