//
//  DishType.swift
//  CookingRecipes
//
//  Created by Victoriia Nestrugina on 7/9/21.
//

import Foundation
import RealmSwift

enum DishType: String, CaseIterable {
    case mainCourse = "Main course"
    case side = "Side"
    case dessert = "Dessert"
    case drink = "Drink"
}
