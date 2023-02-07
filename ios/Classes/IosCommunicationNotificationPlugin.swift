import Flutter
import UIKit

public class IosCommunicationNotificationPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "ios_communication_notification", binaryMessenger: registrar.messenger())
        let instance = IosCommunicationNotificationPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        result("iOS " + UIDevice.current.systemVersion)
        
        switch (call.method) {
        case "showNotification":
            let arguments = call.arguments as? [String: Any] ?? [String: Any]()
            let senderName = arguments["senderName"] as? String ?? ""
            let content = arguments["content"] as? String ?? ""
            guard let avatar = arguments["imageBytes"] as? FlutterStandardTypedData)?.data
            else { return }
            let value = arguments["value"] as? String ?? ""
            CommunicationNotificationPlugin().showNotification(NotificationInfo(senderName: senderName, pngImage: avatar, content: content, value: value))
            result(true)
            break
        default:
            result(FlutterMethodNotImplemented)
            break
        }
    }
}
