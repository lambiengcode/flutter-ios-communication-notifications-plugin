import Flutter
import UIKit

public class IosCommunicationConstant {
    static public let prefixIdentifier: String = "CommunicationNotification"
}

public class IosCommunicationNotificationPlugin: NSObject, FlutterPlugin {
    static public var shared = IosCommunicationNotificationPlugin()
    
    public var flutterChannel: FlutterMethodChannel?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "ios_communication_notification", binaryMessenger: registrar.messenger())
        let instance = IosCommunicationNotificationPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        IosCommunicationNotificationPlugin.shared.flutterChannel = channel
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
