//
//  Analytics.swift
//  GBShop
//
//  Created by Александр Ипатов on 26.03.2021.
//

import Foundation
import FirebaseAnalytics

class FirebaseAnalytics {
    func successfulLogin() {
        Analytics.logEvent(AnalyticsEventLogin, parameters: [
          AnalyticsParameterMethod: "logs in via the app"
          ])
    }
    func failedLogin() {
        Analytics.logEvent("failed_login", parameters: [AnalyticsParameterMethod : "failed logs in via the app"])
    }
    func signUp() {
        Analytics.logEvent(AnalyticsEventSignUp, parameters: [
          AnalyticsParameterMethod: "sign up via the app"
          ])
    }
    func logout() {
        Analytics.logEvent("log_out", parameters: [AnalyticsParameterMethod : "log out via the app"])
    }
    func viewCatalog() {
        Analytics.logEvent("view_catalog", parameters: [AnalyticsParameterMethod : "view catalog"])
    }
    func viewProduct(idProduct: Int) {
        Analytics.logEvent("view_item", parameters: [AnalyticsParameterItemID: idProduct])
    }
    func addToBasket(idProduct: Int) {
        Analytics.logEvent("add_to_cart", parameters: [AnalyticsParameterItemID: idProduct])
    }
    func removeFromBasket(idProduct: Int) {
        Analytics.logEvent("remove_from_cart", parameters: [AnalyticsParameterItemID: idProduct])
    }
    func payBasket(paymentAmount: Int) {
        Analytics.logEvent("pay_basket", parameters: [AnalyticsParameterPrice : paymentAmount])
    }
    func addReview() {
        Analytics.logEvent("add_review", parameters: nil)
    }
}
