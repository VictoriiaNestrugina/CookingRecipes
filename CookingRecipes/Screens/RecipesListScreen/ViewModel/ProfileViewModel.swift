//
//  ProfileViewModel.swift
//  CookingRecipes
//
//  Created by Victoriia Nestrugina on 7/11/21.
//

import Foundation

// Here goes:
// 1. Validation
// 2. Database extraction
// 3. Data transformation to pass to view controller when needed to display

class ProfileViewModel: NSObject {
    
    // MARK: - Properties
    
    var items = [ProfileViewModelItem]()
    
    // MARK: - Initialization
    
    override init() {
        super.init()
        let profile = MockDataProvider.provideMockData()
        let nameItem = ProfileViewModelNameItem(id: profile.id, fullName: profile.fullName)
        items.append(nameItem)
        
        let recipesItem = ProfileViewModelRecipesItem(recipes: profile.recipes)
        items.append(recipesItem)
    }
    
    // MARK: - Database extraction
    
    // This is supposed to get data from the database/file to
//    func getDataFromDatabase(_ filename: String) -> Data {
//
//        return
//    }
    
    // MARK: - Methods
    
    func addRecipe(recipe: Recipe) {
        guard items.count >= 2, let profileViewModelRecipesItem = items[1] as? ProfileViewModelRecipesItem else {
            return
        }
        profileViewModelRecipesItem.recipes.append(recipe)
    }
    
    func removeRecipe(with id: String) {
        guard items.count >= 2, let profileViewModelRecipesItem = items[1] as? ProfileViewModelRecipesItem else {
            return
        }
        
        var isFound = false
        var i = 0
        while i < profileViewModelRecipesItem.recipes.count && !isFound {
            if profileViewModelRecipesItem.recipes[i].id == id {
                isFound = true
            } else {
                i += 1
            }
        }
        profileViewModelRecipesItem.recipes.remove(at: i)
    }
    
    // MARK: - FOR IMPORT, just a scratch
    
    init(from json: String) {
        super.init()
        guard let data = getDataFromFile(filename: json), let profile = Profile(data: data) else {
            return
        }
        
        let nameItem = ProfileViewModelNameItem(id: profile.id, fullName: profile.fullName)
        items.append(nameItem)
        
        let recipesItem = ProfileViewModelRecipesItem(recipes: profile.recipes)
        items.append(recipesItem)
    }
    
    func getDataFromFile(filename: String) -> Data? {
        @objc class TestClass: NSObject {}
        
        let bundle = Bundle(for: TestClass.self)
        if let path = bundle.path(forResource: filename, ofType: "json") {
            return (try? Data(contentsOf: URL(fileURLWithPath: path)))
        }
        return nil
    }
}
