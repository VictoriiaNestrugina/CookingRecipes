//
//  CookingRecipesTests.swift
//  CookingRecipesTests
//
//  Created by Victoriia Nestrugina on 7/9/21.
//

import RealmSwift
import XCTest
@testable import CookingRecipes

// Tests filling the database with mock data
class CookingRecipesDatabaseFillingTests: XCTestCase {
    private enum Constants {
        static let userId = Int.random(in: 1..<1000000)
        static let profileViewModel = ProfileViewModel()
    }

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testDBMockDataFiller() throws {
        guard let realm = try? Realm() else {
            XCTFail("Realm initialization failed")
            return
        }

        let previousDBObjectsNumber = realm.objects(Profile.self).count

        MockDataProvider.fillDatabaseWithMockData(for: Constants.userId)

        let storedProfiles = realm.objects(Profile.self).filter {
            return $0.id == CookingRecipesDatabaseFillingTests.Constants.userId
        }
        XCTAssertEqual(storedProfiles.count, 1)
        let profile = storedProfiles.first!
        XCTAssertEqual(profile.id, Constants.userId)
        XCTAssertEqual(profile.recipes.count, 8)

        let currentDBObjectsNumber = realm.objects(Profile.self).count
        XCTAssertEqual(currentDBObjectsNumber - 1, previousDBObjectsNumber)
    }

    func testDBMockDataRemoval() throws {
        guard let realm = try? Realm() else {
            XCTFail("Realm initialization failed")
            return
        }

        let previousDBObjectsNumber = realm.objects(Profile.self).count
        MockDataProvider.clearDatabase(for: Constants.userId)
        let storedProfiles = realm.objects(Profile.self).filter {
            return $0.id == CookingRecipesDatabaseFillingTests.Constants.userId
        }

        XCTAssertEqual(storedProfiles.count, 0)

        let currentDBObjectsNumber = realm.objects(Profile.self).count
        XCTAssertEqual(currentDBObjectsNumber + 1, previousDBObjectsNumber)
    }
}

// Test adding, removing editing a recipe in the database
// Assumes the database filling and clearing works correctly
class CookingRecipesDBSimpleOperationsTests: XCTestCase {
    private enum Constants {
        static let userId = Int.random(in: 1..<1000000)
        static let profileViewModel = ProfileViewModel(profile: MockDataProvider.provideMockData(for: userId))
    }

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testRecipeAddition() throws {
        let previousRecipesNumber = Constants.profileViewModel.provideRecipes()?.count ?? 0

        let newRecipe = Recipe()
        newRecipe.ingredients.append(objectsIn: ["Ingredient 1", "Ingredient 2", "Ingredient 3"])
        newRecipe.method = "A method of cooking the dish"
        newRecipe.title = "Title"
        newRecipe.type = "Main"

        Constants.profileViewModel.addRecipe(recipe: newRecipe)

        let currentRecipesNumber = Constants.profileViewModel.provideRecipes()?.count ?? 0
        XCTAssertEqual(previousRecipesNumber + 1, currentRecipesNumber)

        let savedRecipes = Constants.profileViewModel.provideRecipes()?.filter {
            return $0.id == newRecipe.id
        }

        XCTAssertNotNil(savedRecipes)
        XCTAssertEqual(savedRecipes!.count, 1)
        XCTAssertEqual(savedRecipes![0].id, newRecipe.id)
    }

    func testRecipeRemoval() throws {
        let previousRecipesNumber = Constants.profileViewModel.provideRecipes()?.count

        guard let number = previousRecipesNumber else {
            XCTFail("Profile filling failed")
            return
        }

        let indexOfRecipeToRemove = Int.random(in: 0..<number)
        let recipeToRemoveId = Constants.profileViewModel.provideRecipes()![indexOfRecipeToRemove].id

        Constants.profileViewModel.removeRecipe(with: recipeToRemoveId)

        let currentRecipesNumber = Constants.profileViewModel.provideRecipes()?.count ?? 0
        XCTAssertEqual(number - 1, currentRecipesNumber)

        let savedRecipes = Constants.profileViewModel.provideRecipes()?.filter {
            return $0.id == recipeToRemoveId
        }

        XCTAssertNotNil(savedRecipes)
        XCTAssertEqual(savedRecipes!.count, 0)
    }

    func testRecipeEditing() throws {
        let previousRecipesNumber = Constants.profileViewModel.provideRecipes()?.count ?? 0

        let indexOfRecipeToEdit = Int.random(in: 0..<previousRecipesNumber)
        let recipeToEditId = Constants.profileViewModel.provideRecipes()![indexOfRecipeToEdit]

        let newRecipe = Recipe()
        newRecipe.ingredients.append(objectsIn: ["Ingredient 1", "Ingredient 2", "Ingredient 3"])
        newRecipe.method = "A method of cooking the dish"
        newRecipe.title = "Title"
        newRecipe.type = "Main"

        Constants.profileViewModel.edit(recipe: recipeToEditId, with: newRecipe)
        let currentRecipesNumber = Constants.profileViewModel.provideRecipes()?.count ?? 0
        XCTAssertEqual(previousRecipesNumber, currentRecipesNumber)

        let savedRecipes = Constants.profileViewModel.provideRecipes()?.filter {
            return $0.id == recipeToEditId.id
        }

        XCTAssertNotNil(savedRecipes)
        XCTAssertEqual(savedRecipes!.count, 1)
        XCTAssertEqual(savedRecipes![0].title, newRecipe.title)
        XCTAssertEqual(savedRecipes![0].method, newRecipe.method)
        XCTAssertEqual(savedRecipes![0].type, newRecipe.type)
        XCTAssertEqual(savedRecipes![0].ingredients.count, newRecipe.ingredients.count)

        var areIngredientsOk = true
        var index = 0
        while index < savedRecipes![0].ingredients.count && areIngredientsOk {
            if savedRecipes![0].ingredients[index] != newRecipe.ingredients[index] {
                areIngredientsOk = false
            } else {
                index += 1
            }
        }
        XCTAssertTrue(areIngredientsOk)
    }
}
