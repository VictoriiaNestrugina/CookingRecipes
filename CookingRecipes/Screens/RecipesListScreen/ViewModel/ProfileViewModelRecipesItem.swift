//
//  ProfileViewModelRecipesItem.swift
//  CookingRecipes
//
//  Created by Victoriia Nestrugina on 7/12/21.
//

import Foundation

class ProfileViewModelRecipesItem: ProfileViewModelItem {
    var recipes: [Recipe]
    
    var rowCount: Int {
        return recipes.count
    }
    
    init(recipes: [Recipe]) {
        self.recipes = recipes
    }
}
