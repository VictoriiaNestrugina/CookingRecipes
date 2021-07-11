//
//  Recipe.swift
//  CookingRecipes
//
//  Created by Victoriia Nestrugina on 7/9/21.
//

import Foundation
import RealmSwift
import UIKit

class Recipe: Object {
    @objc dynamic var id = ""
    
    @objc dynamic var title = ""
    var ingredients = List<String>()
    @objc dynamic var method = ""
    @objc dynamic var creationDate = Date()
    @objc dynamic var type = DishType.baking.rawValue
    @objc dynamic var image = NSData()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func create(withTitle title: String,
                       ingredients: [String],
                       method: String,
                       type: DishType,
                       image: UIImage) -> Recipe {
        let recipe = Recipe()
        recipe.title = title
        recipe.ingredients.append(objectsIn: ingredients)
        recipe.method = method
        recipe.type = type.rawValue
        recipe.image = NSData(data: image.jpegData(compressionQuality: 1.0)!)
        
        return recipe
    }
}
