//
//  NotificationDelegate.swift
//  Chillkra
//
//  Created by Van Huy on 06/10/2022.
//

import Foundation
import UserNotifications
import SwiftUI
class NotificationDelegate: NSObject,ObservableObject,UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge,.banner,.sound])
    }
}
