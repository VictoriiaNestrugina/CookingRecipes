//
//  AuthorizationViewController.swift
//  CookingRecipes
//
//  Created by Victoriia Nestrugina on 7/14/21.
//

import UIKit

class AuthorizationViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let recipesListSegueName = "RecipesListSegue"
    }

    // MARK: - Properties
    
    var profileViewModel = ProfileViewModel()
        
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileViewModel.delegate = self
    }
    
    // MARK: - IBAction
    
    @IBAction func authorize(_ sender: UIButton) {
        Indicator.sharedInstance.showIndicator()
        profileViewModel.authorize()
    }
    
    @IBAction func fillDBWithMockData(_ sender: UIButton) {
        MockDataProvider.fillDatabaseWithMockData()
    }
    
    @IBAction func clearDB(_ sender: UIButton) {
        MockDataProvider.clearDatabase()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navigationController = segue.destination as! UINavigationController
        if let recipesListViewController = navigationController.topViewController as? RecipesListViewController {
            recipesListViewController.profileViewModel = self.profileViewModel
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        
        if let ident = identifier,
           ident == Constants.recipesListSegueName,
           !UserDefaults.standard.bool(forKey: UserDefaultsConstants.isAuthorized) {
                return false
        }
        return true
    }
}

extension AuthorizationViewController: AuthorizationDelegate {
    func authorizor(_ loader: ProfileViewModel, didFinishLoadingWithResult result: Bool) {
        switch result {
        case true:
            DispatchQueue.main.async {
                Indicator.sharedInstance.hideIndicator()
                self.performSegue(withIdentifier: Constants.recipesListSegueName, sender: nil)
            }
            
        case false:
            break
        }
    }
}
