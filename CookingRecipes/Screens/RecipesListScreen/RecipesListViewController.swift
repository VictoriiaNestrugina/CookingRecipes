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
    
    // For search
    var filteredRecipes: [Recipe] = []
    let searchController = UISearchController(searchResultsController: nil)
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
//??
//        tableView.dataSource = profileViewModel
        setupSearchBar()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Here goes the data fetching from the database
        
        tableView.reloadData()
    }
    
    // MARK: - Private methods
    
    private func setupSearchBar() {
        // Informs RecipesListViewController class of changes if the search bar
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        // Attaching the search bar to navigation bar
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        
        // Setup for the scope bar
        searchController.searchBar.scopeButtonTitles = ["All"] + DishType.allCases.map { $0.rawValue }
        searchController.searchBar.delegate = self
    }
    
    private func getData() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func filterContentForSearchText(_ searchText: String,
                                            category: DishType?,
                                            date: Date?) {
        filteredRecipes = profile.recipes.filter { (recipe: Recipe) -> Bool in
            let doesCategoryMatch = category == nil || recipe.type == category
            
            if isSearchBarEmpty {
                return doesCategoryMatch
            } else {
                return doesCategoryMatch && recipe.title.lowercased().contains(searchText.lowercased())
            }
        }
        
        tableView.reloadData()
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

extension RecipesListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isFiltering {
//            return filteredRecipes.count
//        }
    
//        return profile.recipes.count //or smth
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCellIdentifier", for: indexPath) as! RecipeTableViewCell
        //let recipe: Recipe
//        if isFiltering {
//            recipe = filteredRecipes[indexPath.row]
//        } else {
//            recipe = profile.recipes[indexPath.row]
//        }
        //cell.title.text = recipe.title
        //cell.dishType = recipe.dishType.rawValue
        //cell.image = recipe.image
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        //if profile.recipes.count > indexPath.row {
        //let recipe = recipes[indexPath.row]
        // here goes deleting the thing from the database - todo!!!
        
        //profile.recipes.remove(at: indexPath.row)
        //tableView.deleteRows(at: [indexPath], with: .fade)
        
        //}
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
//            let recipe: Recipe
//            if isFiltering {
//                recipe = filteredRecipes[indexPath.row]
//            } else {
//                recipe = profile.recipes[indexPath.row]
//            }
            // here goes deleting the thing from the database - todo!!!
            
            //profile.recipes.remove(at: indexPath.row)
            //tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
}

extension RecipesListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let category = DishType(rawValue: searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])
        filterContentForSearchText(searchBar.text!, category: category, date: nil)
    }
}

extension RecipesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        let category = DishType(rawValue: searchBar.scopeButtonTitles![selectedScope])
        filterContentForSearchText(searchBar.text!, category: category, date: nil)
    }
}
