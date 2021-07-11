//
//  ProfileViewModelItem.swift
//  CookingRecipes
//
//  Created by Victoriia Nestrugina on 7/10/21.
//

import Foundation

protocol ProfileViewModelItem {
    var rowCount: Int {
        get
    }
}

extension ProfileViewModelItem {
    var rowCount: Int {
        return 0
    }
}
