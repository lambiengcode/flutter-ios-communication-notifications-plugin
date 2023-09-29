import Intents
import UIKit
import UserNotifications

class CommunicationNotificationPlugin {
    func showNotification(_ notificationInfo: NotificationInfo) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings {
            settings in switch settings.authorizationStatus {
            case .authorized:
                self.dispatchNotification(notificationInfo)
            case .denied:
                return
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) {
                    didAllow, _ in
                    if didAllow {
                        self.dispatchNotification(notificationInfo)
                    }
                }
            default: return
            }
        }
    }
    
    func dispatchNotification(_ notificationInfo: NotificationInfo) {
        if #available(iOS 15.0, *) {
            let uuid = UUID.init().uuidString
            let currentTime = Date().timeIntervalSince1970
            let identifier = "\(IosCommunicationConstant.prefixIdentifier):\(uuid):\(currentTime)"

            var content = UNMutableNotificationContent()
            
            content.title = notificationInfo.senderName
            content.subtitle = ""
            content.body = notificationInfo.content
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "alarm"))
            content.categoryIdentifier = identifier
            content.userInfo = ["data": notificationInfo.value]
            
            var personNameComponents = PersonNameComponents()
            personNameComponents.nickname = notificationInfo.senderName
            
            let avatar = INImage(imageData: notificationInfo.pngImage)
            
            let senderPerson = INPerson(
                personHandle: INPersonHandle(value: notificationInfo.value, type: .unknown),
                nameComponents: personNameComponents,
                displayName: notificationInfo.senderName,
                image: avatar,
                contactIdentifier: nil,
                customIdentifier: nil,
                isMe: false,
                suggestionType: .none
            )
            
            let mPerson = INPerson(
                personHandle: INPersonHandle(value: "", type: .unknown),
                nameComponents: nil,
                displayName: nil,
                image: nil,
                contactIdentifier: nil,
                customIdentifier: nil,
                isMe: true,
                suggestionType: .none
            )
            
            
            let intent = INSendMessageIntent(
                recipients: [mPerson],
                outgoingMessageType: .outgoingMessageText,
                content: notificationInfo.content,
                speakableGroupName: INSpeakableString(spokenPhrase: notificationInfo.senderName),
                conversationIdentifier: notificationInfo.senderName,
                serviceName: nil,
                sender: senderPerson,
                attachments: nil
            )
            
            intent.setImage(avatar, forParameterNamed: \.sender)
            
            let interaction = INInteraction(intent: intent, response: nil)
            interaction.direction = .incoming
            
            interaction.donate(completion: nil)
            
            do {
                content = try content.updating(from: intent) as! UNMutableNotificationContent
            } catch {
                // Handle errors
            }
            
            // Show 30 seconds from now
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            // Request from identifier
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: nil)
            
            // actions
            let close = UNNotificationAction(identifier: "close", title: "Close", options: .destructive)
//            let reply = UNNotificationAction(identifier: "reply", title: "Reply", options: .foreground)
            let category = UNNotificationCategory(identifier: identifier, actions: [close], intentIdentifiers: [])
            
            UNUserNotificationCenter.current().setNotificationCategories([category])
            
            // Add notification request
            UNUserNotificationCenter.current().add(request)
        }
    }
}
