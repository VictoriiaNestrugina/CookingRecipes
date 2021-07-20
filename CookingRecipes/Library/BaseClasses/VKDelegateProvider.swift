//
//  VKDelegateProvider.swift
//  CookingRecipes
//
//  Created by Victoriia Nestrugina on 7/16/21.
//

import Foundation
import SwiftyVK
import UIKit

final class VKDelegateProvider: SwiftyVKDelegate {
    
    // MARK: - Constants
    
    let appId = "7899743"
    let scopes: Scopes = [.email, .offline]
    
    // MARK: Initialization
    
    init() {
        VK.setUp(appId: appId, delegate: self)
    }
    
    // MARK: - SwiftyVKDelegate
    
    func vkNeedsScopes(for sessionId: String) -> Scopes {
        return scopes
    }

    func vkNeedToPresent(viewController: VKViewController) {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(viewController, animated: true, completion: nil)
        }
        
    }
    
    func vkTokenCreated(for sessionId: String, info: [String : String]) {
        print("token created in session \(sessionId) with info \(info)")
        UserDefaults.standard.set(true, forKey: UserDefaultsConstants.isAuthorized)
        UserDefaults.standard.set(info[UserDefaultsConstants.userId], forKey: UserDefaultsConstants.userId)
    }
    
    func vkTokenUpdated(for sessionId: String, info: [String : String]) {
        print("token updated in session \(sessionId) with info \(info)")
    }
    
    func vkTokenRemoved(for sessionId: String) {
        print("token removed in session \(sessionId)")
        UserDefaults.standard.set(false, forKey: UserDefaultsConstants.isAuthorized)
        UserDefaults.standard.removeObject(forKey: UserDefaultsConstants.userId)
        UserDefaults.standard.removeObject(forKey: UserDefaultsConstants.fullName)
    }
    
}
