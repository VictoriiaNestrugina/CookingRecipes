//
//  ProfileViewModel.swift
//  CookingRecipes
//
//  Created by Victoriia Nestrugina on 7/11/21.
//

import Foundation

class ProfileViewModel: NSObject {
    
    // MARK: - Properties
    
    var items = [ProfileViewModelItem]()
    
    // MARK: - Initialization
    
    override init() {
        super.init()
        guard let data =  else {

        }
    }
    
    // MARK: - Database extraction
    
    // This is supposed to get data from the database/file to
//    func getDataFromDatabase(_ filename: String) -> Data {
//
//        return
//    }
    
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
    }
}
