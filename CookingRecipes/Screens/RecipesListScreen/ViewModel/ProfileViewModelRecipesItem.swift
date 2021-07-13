//
//  ProfileViewModelRecipesItem.swift
//  CookingRecipes
//
//  Created by Victoriia Nestrugina on 7/12/21.
//

import Foundation
import RealmSwift

class ProfileViewModelRecipesItem: ProfileViewModelItem {
    var recipes: List<Recipe>
    
    var rowCount: Int {
        return recipes.count
    }
    
    init(recipes: List<Recipe>) {
        self.recipes = recipes
    }
}
