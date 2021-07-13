//
//  ProfileViewModelRecipeItem.swift
//  CookingRecipes
//
//  Created by Victoriia Nestrugina on 7/11/21.
//

import Foundation
import UIKit
import RealmSwift

class ProfileViewModelRecipeItem: ProfileViewModelItem {
    var id: String
    
    var title: String
    var ingredients: [String]
    var method: String
    var creationDate: Date
    var type: DishType
    
    var image: UIImage
    
    init(id: String,
        title: String,
         ingredients: List<String>,
         method: String,
         creationDate: Date,
         type: String,
         image: NSData) {
        self.id = id
        self.title = title
        self.ingredients = Array(ingredients)
        self.method = method
        self.creationDate = creationDate
        self.type = DishType(rawValue: type)!
        self.image = UIImage(data: image as Data, scale: 1.0)!
    }
}
