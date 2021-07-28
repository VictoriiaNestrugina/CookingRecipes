//
//  RecipeEntry.swift
//  CookingRecipes
//
//  Created by Victoriia Nestrugina on 7/28/21.
//

import Foundation

struct RecipeEntry: Codable {
    var title: String
    var ingredients: [String]
    var method: String
    var creationDate: String
    var type: DishType
    var image: String
}
