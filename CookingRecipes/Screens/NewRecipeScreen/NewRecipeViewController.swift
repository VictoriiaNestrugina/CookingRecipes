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

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var ingredients: UITextView!
    @IBOutlet weak var method: UITextView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var dishType: UIPickerView!

    // MARK: - Properties

    var pickerData: [String] = [String]()
    var selectedType: String?
    weak var delegate: NewRecipeViewControllerDelegate?
    var recipe: Recipe?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        populateDishTypePicker()
        setupDataInView()
    }

    // MARK: - IBActions

    @IBAction func uploadImage(_ sender: UIButton) {
        presentPhotoPicker(sourceType: .photoLibrary)
    }

    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        let recipeTitle = titleTextField.text ?? ""
        let recipeIngredients = (ingredients.text ?? "").split(separator: "\n").map {
            String($0)
        }

        let recipeMethod = method.text ?? ""
        let recipeImage = image.image ?? UIImage()
        let recipeDishType = selectedType!

        let newRecipe = Recipe.create(withTitle: recipeTitle,
                                      ingredients: recipeIngredients,
                                      method: recipeMethod,
                                      type: DishType(rawValue: recipeDishType)!,
                                      image: recipeImage)

        delegate?.newRecipeViewController(self, didAddRecipe: newRecipe)

        dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Private methods

    private func populateDishTypePicker() {
        for value in DishType.allCases {
            pickerData.append(value.rawValue)
        }

        dishType.delegate = self
        dishType.dataSource = self
    }

    private func setupDataInView() {
        guard let data = recipe else {
            return
        }

        titleTextField.text = data.title
        ingredients.text = data.ingredients.joined(separator: "\n")
        method.text = data.method
        image.image = data.uiImage

        dishType.selectRow(DishType.getIndex(of: data.type)!, inComponent: 0, animated: false)
        selectedType = data.type
    }
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

extension NewRecipeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private func presentPhotoPicker(sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        present(picker, animated: true)
    }

    // Handling Image Picker Selection
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        self.image.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
    }
}
