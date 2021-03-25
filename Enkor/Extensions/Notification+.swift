//
//  File.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/17.
//

import Foundation

extension Notification.Name  {
    static let didLogin = Notification.Name("didLogin")
    static let loggedIn = Notification.Name("userLoggedIn")
    static let logut = Notification.Name("logout")
    static let IAPHelperPurchaseNotification = Notification.Name("IAPHelperPurchaseNotification")
    static let IAPHelperPurchaseNotificationFailed = Notification.Name("IAPHelperPurchaseNotificationFailed")
    static let UserCoinNeedUpdateNotification = Notification.Name("UserCoinNeedUpdateNotification")
}
