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
    
    init(id: String,
         fullName: String) {
        self.id = id
        self.fullName = fullName
    }
}
