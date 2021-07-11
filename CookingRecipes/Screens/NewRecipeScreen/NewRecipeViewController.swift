//
//  NewRecipeViewController.swift
//  CookingRecipes
//
//  Created by Victoriia Nestrugina on 7/11/21.
//

import UIKit

class NewRecipeViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var title: UITextField!
    @IBOutlet weak var ingredients: UITextField!
    @IBOutlet weak var method: UITextField!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var dishType: UIPickerView!
    
    // MARK: - Properties
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
