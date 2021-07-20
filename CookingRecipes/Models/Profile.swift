//
//  Profile.swift
//  CookingRecipes
//
//  Created by Victoriia Nestrugina on 7/9/21.
//

import Foundation
import RealmSwift

class Profile: Object {
    
    // MARK: - Properties
    
    @objc dynamic var id = 0
    @objc dynamic var fullName = ""
    var recipes = List<Recipe>()
    
    // MARK: - Initialization
    
    // Здесь инициализация из Data, которая по цепочке передается как массив String вложенным объектам
//    init(data: Data) {
//
//    }
    
    override init() {
        super.init()
    }
    
    init(id: Int, fullName: String) {
        self.id = id
        self.fullName = fullName
    }
    
    // MARK: - Static functions
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func create(withName name: String, recipes: [Recipe]) -> Profile {
        let profile = Profile()
        profile.fullName = name
        profile.recipes.append(objectsIn: recipes)
        
        return profile
    }
    
    // MARK: - FOR IMPORT, just a scratch
    init?(data: Data) {
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let body = json["data"] as? [String: Any] {
                self.fullName = body["fullName"] as! String
                self.id = body["id"] as! Int
//                self.recipes = body["recipes"] as? [[String: Any]] {
//                    self.recipes = recipes.map {
//                        Recipe(json: $0)
//                    }
//                }
            }
        } catch {
            print("Erroe deserializing JSON")
            return nil
        }
    }
}
