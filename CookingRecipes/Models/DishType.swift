//
//  DishType.swift
//  CookingRecipes
//
//  Created by Victoriia Nestrugina on 7/9/21.
//

import Foundation
import RealmSwift

enum DishType: String, CaseIterable {
    case mainCourse = "Main"
    case side = "Side"
    case dessert = "Dessert"
    case drink = "Drink"
    
    static func getIndex(of value: String) -> Int? {
        switch value {
        case DishType.mainCourse.rawValue:
            return 0
        case DishType.side.rawValue:
            return 1
        case DishType.dessert.rawValue:
            return 2
        case DishType.drink.rawValue:
            return 3
        default:
            return nil
        }
    }
}
