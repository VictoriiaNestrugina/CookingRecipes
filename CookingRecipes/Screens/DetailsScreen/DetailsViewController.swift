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
    @IBOutlet weak var ingredientsTextField: UITextField!
    @IBOutlet weak var methodTextField: UITextField!
    @IBOutlet weak var recipeImageView: UIImageView!
    
    // MARK: - Properties
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func returnTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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
