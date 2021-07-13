//
//  NewRecipeViewControllerDelegate.swift
//  CookingRecipes
//
//  Created by Victoriia Nestrugina on 7/13/21.
//

import Foundation

protocol NewRecipeViewControllerDelegate {
    func newRecipeViewController(_ newRecipeViewController: NewRecipeViewController, didAddRecipe recipe: Recipe)
}
