//
//  Profile.swift
//  CookingRecipes
//
//  Created by Victoriia Nestrugina on 7/9/21.
//

import Foundation
import RealmSwift

class Profile: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var fullName = ""
    var recipes = List<Recipe>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func create(withName name: String, recipes: [Recipe]) -> Profile {
        let profile = Profile()
        profile.fullName = name
        profile.recipes.append(objectsIn: recipes)
        
        return profile
    }
}
