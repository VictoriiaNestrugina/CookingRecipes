//
//  DetailsViewController.swift
//  CookingRecipes
//
//  Created by Victoriia Nestrugina on 7/12/21.
//

import UIKit

class DetailsViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var ingredientsTextField: UITextView!
    @IBOutlet weak var methodTextField: UITextView!
    @IBOutlet weak var recipeImageView: UIImageView!
    
    // MARK: - Properties
    
    var data: Recipe?
    var profileViewModel: ProfileViewModel?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDataInView()
        setupNotifications()
    }
    
    // MARK: - IBAction
    
    @IBAction func returnTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private methods
    
    @objc private func setupDataInView() {
        guard let data = data else {
            return
        }
        titleLabel.text = data.title
        typeLabel.text = data.type
        ingredientsTextField.text = data.ingredients.joined(separator: "\n")
        methodTextField.text = data.method
        recipeImageView.image = data.uiImage
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(setupDataInView), name: Notification.Name(GlobalConstants.databaseUpdateNotificationName), object: nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        if let newRecipeViewController = navigationController.topViewController as? NewRecipeViewController {
            newRecipeViewController.newRecipeDelegate = self
            newRecipeViewController.recipe = data
        }
    }
}

extension DetailsViewController: NewRecipeViewControllerDelegate {
    func newRecipeViewController(_ newRecipeViewController: NewRecipeViewController, didAddRecipe recipe: Recipe) {
        guard let data = data else {
            return
        }
        profileViewModel?.edit(recipe: data, with: recipe)
        NotificationCenter.default.post(name: Notification.Name(GlobalConstants.databaseUpdateNotificationName),
                                        object: nil)
    }
}
