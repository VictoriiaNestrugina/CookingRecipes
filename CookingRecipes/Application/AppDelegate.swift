//
//  AppDelegate.swift
//  CookingRecipes
//
//  Created by Victoriia Nestrugina on 7/9/21.
//

import SwiftyVK
import UIKit

var vkDelegateProvider: SwiftyVKDelegate?

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        vkDelegateProvider = VKDelegateProvider()
        return true
    }

    @available(iOS 9.0, *)
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        let app = options[.sourceApplication] as? String
        VK.handle(url: url, sourceApplication: app)
        return true
    }

    func application(_ application: UIApplication,
                     open url: URL,
                     sourceApplication: String?,
                     annotation: Any) -> Bool {
        VK.handle(url: url, sourceApplication: sourceApplication)
        return true
    }
}
