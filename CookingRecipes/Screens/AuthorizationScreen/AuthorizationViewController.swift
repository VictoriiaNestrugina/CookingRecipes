//
//  AuthorizationViewController.swift
//  CookingRecipes
//
//  Created by Victoriia Nestrugina on 7/14/21.
//

import RealmSwift
import SwiftyVK
import UIKit

class AuthorizationViewController: UIViewController {

    // MARK: - Private properties
    
    let localRealm = try! Realm()
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBAction
    @IBAction func authorize(_ sender: UIButton) {
        VK.sessions.default.logIn(onSuccess: onSuccess(info:),
                                  onError: onFailure(error:)
        )
    }
    
    // MARK: - Private methods
    
    private func onSuccess(info: [String: String]) {
        print("SwiftyVK: success authorize with", info)
        saveUserInfo()
    }
    
    private func onFailure(error: VKError) {
        print("SwiftyVK: authorize failed with", error)
        if case .sessionAlreadyAuthorized(_) = error {
            saveUserInfo()
        }
    }
    
    private func saveUserInfo() {
        VK.API.Account.getProfileInfo(.empty)
            .onSuccess { info in
                let json = try JSONSerialization.jsonObject(with: (JSON(info).rawString()?.data(using: .utf8))!, options: [])
                if let dictionary = json as? [String: Any] {
                    let dict = dictionary.compactMapValues{ $0 as? String }
                    if let firstName = dict["first_name"], let lastName = dict["last_name"] {
                        let fullName = firstName + " " + lastName
                        UserDefaults.standard.set(fullName, forKey: UserDefaultsConstants.fullName)
                    }
                }
                
                ///////
                
            }
            .onError {
                print("SwiftyVK: getting profile info failed with", $0)
            }
            .send()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    //}
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if let ident = identifier,
           ident == "RecipesListSegue",
           !UserDefaults.standard.bool(forKey: UserDefaultsConstants.isAuthorized) {
            return false
        }
        return true
    }
}
