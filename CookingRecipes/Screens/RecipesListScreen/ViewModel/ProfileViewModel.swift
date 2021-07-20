//
//  ProfileViewModel.swift
//  CookingRecipes
//
//  Created by Victoriia Nestrugina on 7/11/21.
//

import RealmSwift
import SwiftyVK
import Foundation

class ProfileViewModel: NSObject {
    
    // MARK: - Private properties
    
    private var profile: Profile?
    
    // MARK: - Properties
    
    let group = DispatchGroup()
    var delegate: AuthorizationDelegate?
    
    // MARK: - Initialization
    
    override init() {
        super.init()
    }
    
    // MARK: - Methods
    
    func authorize() {
        VK.sessions.default.logIn(onSuccess: onAuthorizationSuccess(info:),
                                  onError: onAuthorizationFailure(error:))
    }
    
    func addRecipe(recipe: Recipe) {
        let realm = try! Realm()

        guard let profile = self.profile else {
            return
        }
        
        try! realm.write {
            profile.recipes.append(recipe)
        }
    }
    
    func removeRecipe(with id: String) {
        let realm = try! Realm()
        
        guard let profile = self.profile else {
            return
        }
        var isFound = false
        var i = 0
        while i < profile.recipes.count && !isFound {
            if profile.recipes[i].id == id {
                isFound = true
            } else {
                i += 1
            }
        }
        
        try! realm.write {
            profile.recipes.remove(at: i)
        }
    }
    
    func edit(recipe: Recipe, with value: Recipe) {
        let realm = try! Realm()
        try! realm.write {
            recipe.title = value.title
            
            recipe.ingredients.removeAll()
            recipe.ingredients.append(objectsIn: Array(value.ingredients))
            
            recipe.method = value.method
            recipe.type = value.type
            recipe.image = value.image
        }
    }
    
    func provideFullName() -> String? {
        return profile?.fullName
    }
    
    func provideRecipes() -> [Recipe]? {
        guard let profile = profile else {
            return nil
        }
        return Array(profile.recipes)
    }
    
    // MARK: - Private methods
    
    private func onAuthorizationSuccess(info: [String: String]) {
        print("SwiftyVK: success authorize with", info)
        saveUserInfo()
    }
    
    private func onAuthorizationFailure(error: VKError) {
        print("SwiftyVK: authorize failed with", error)
        if case .sessionAlreadyAuthorized(_) = error {
            saveUserInfo()
        } else {
            group.leave()
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
                
                // Show recipes saved in the database
                DispatchQueue.main.async {
                    let realm = try! Realm()
                    
                    let storedProfile = realm.objects(Profile.self).filter {
                        return $0.id == UserDefaults.standard.integer(forKey: UserDefaultsConstants.userId)
                    }
                    
                    print("Stored profiles: \(storedProfile.count)")
                    
                    if storedProfile.isEmpty {
                        self.profile = Profile(id: UserDefaults.standard.integer(forKey: UserDefaultsConstants.userId),
                                               fullName: UserDefaults.standard.string(forKey: UserDefaultsConstants.fullName) ?? "")
                        
                        try! realm.write {
                            realm.add(self.profile!)
                        }
                    } else {
                        self.profile = storedProfile.first
                    }
                    self.delegate?.authorizor(self, didFinishLoadingWithResult: UserDefaults.standard.bool(forKey: UserDefaultsConstants.isAuthorized))
                }
            }
            .onError {
                print("SwiftyVK: getting profile info failed with", $0)
            }
            .send()
    }
    
    // MARK: - FOR IMPORT, just a scratch
    
    init(from json: String) {
        super.init()
        guard let data = getDataFromFile(filename: json), let profile = Profile(data: data) else {
            return
        }
        self.profile = profile
    }
    
    func getDataFromFile(filename: String) -> Data? {
        @objc class TestClass: NSObject {}
        
        let bundle = Bundle(for: TestClass.self)
        if let path = bundle.path(forResource: filename, ofType: "json") {
            return (try? Data(contentsOf: URL(fileURLWithPath: path)))
        }
        return nil
    }
}
