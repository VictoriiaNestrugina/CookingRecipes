//
//  RecipesListViewController.swift
//  CookingRecipes
//
//  Created by Victoriia Nestrugina on 7/10/21.
//

import UIKit
import RealmSwift

class RecipesListViewController: UIViewController, UITableViewDelegate {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var profileViewModel: ProfileViewModel?
    // We need to:
    //1. request the data
    //2. Pass it to ViewModel
    //3. Reload TableView on data update
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        tableView.dataSource = profileViewModel
        
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
