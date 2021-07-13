//
//  NewRecipeViewController.swift
//  CookingRecipes
//
//  Created by Victoriia Nestrugina on 7/11/21.
//

import RealmSwift
import UIKit

class NewRecipeViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var title: UITextField!
    @IBOutlet weak var ingredients: UITextField!
    @IBOutlet weak var method: UITextField!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var dishType: UIPickerView!
    
    // MARK: - Properties
    
    var pickerData: [String] = [String]()
    var selectedType: String?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        populateDatePicker()
    }
    
    // MARK: - IBActions
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        let recipeTitle = title.text ?? ""
        let recipeIngredients = ingredients.text ?? ""
        let recipeMethod = method.text ?? ""
        let recipeImage = image.image
        let recipeDishType = selectedType
        
        //Here goes the creation of a database object and its saving
        let newRecipe = Recipe()
        newRecipe.title = recipeTitle
        newRecipe.ingredients = recipeIngredients
        newRecipe.method = recipeMethod
        newRecipe.image = recipeImage
        newRecipe.id = UUID().uuidString
        newRecipe.creationDate = Date()
        
        // TODO: Realm
        // Not sure if recipe model should be directly used here or ViewModel somehow
        // ... code
        try! realm.write(newRecipe)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private methods
    
    private func populateDatePicker() {
        for value in DishType.allCases {
            pickerData.append(value.rawValue)
        }
        
        dishType.delegate = self
        dishType.dataSource = self
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NewRecipeViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedType = pickerData[row]
    }
}

extension NewRecipeViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
}
