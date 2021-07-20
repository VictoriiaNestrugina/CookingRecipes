//
//  AuthorizationDelegate.swift
//  CookingRecipes
//
//  Created by Victoriia Nestrugina on 7/20/21.
//

import Foundation

protocol AuthorizationDelegate {
    func authorizor(_ loader: ProfileViewModel, didFinishLoadingWithResult result: Bool)
}
