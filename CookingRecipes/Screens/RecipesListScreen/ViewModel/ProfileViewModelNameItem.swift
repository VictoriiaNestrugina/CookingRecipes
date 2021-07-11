//
//  ProfileViewModelNameItem.swift
//  CookingRecipes
//
//  Created by Victoriia Nestrugina on 7/11/21.
//

import Foundation
import RealmSwift

class ProfileViewModelNameItem: ProfileViewModelItem {
    var id: String
    var fullName: String
    var recipes: [Recipe]
    
    init(id: String,
         fullName: String,
         recipes: List<Recipe>) {
        self.id = id
        self.fullName = fullName
        self.recipes = Array(recipes)
    }
    
    var rowCount: Int {
        return recipes.count
    }V
}
