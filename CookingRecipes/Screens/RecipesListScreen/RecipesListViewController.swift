//
//  RecipesListViewController.swift
//  CookingRecipes
//
//  Created by Victoriia Nestrugina on 7/10/21.
//

import UIKit
import RealmSwift
import SwiftyVK

class RecipesListViewController: UIViewController, UITableViewDelegate {
    
    // MARK: - Constants
    
    private enum Constants {
        static let screenWidth = UIScreen.main.bounds.width
        static let screenHeight = UIScreen.main.bounds.height
        static let detailsSegueName = "detailsSegue"
    }
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private properties
    
    private var recipes: [Recipe]?
    private var fullName: String?
    private var recipeToPass: Recipe?
    
    // MARK: - Properties
    
    var profileViewModel: ProfileViewModel?
    
    // For search
    var filteredRecipes: [Recipe] = []
    let searchController = UISearchController(searchResultsController: nil)
    var selectedCategory: DishType?
    var selectedDate: Date?
        
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
        
        setupSearchBar()
        setupData()
        setupTableView()
        setupNotifications()
    }
    
    // MARK: - IBAction
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        VK.sessions.default.logOut()
        dismiss(animated: true, completion: nil)
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
        
        // Setup for date picker button
        searchController.searchBar.showsBookmarkButton = true
        searchController.searchBar.setImage(UIImage(named: "Sort"), for: .bookmark, state: .normal)
        
    }
    
    private func setupData() {
        fullName = profileViewModel?.provideFullName()
        recipes = profileViewModel?.provideRecipes()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: Notification.Name(GlobalConstants.databaseUpdateNotificationName), object: nil)
    }
    
    @objc func reloadData() {
        recipes = profileViewModel?.provideRecipes()
        tableView.reloadData()
    }
    
    private func filterContentForSearchText(_ searchText: String,
                                            category: DishType?,
                                            date: Date?) {
        
//        guard let profileViewModel = profileViewModel,
//              profileViewModel.items.count > 0,
//              let profileViewModelRecipesItem = profileViewModel.items[1] as? ProfileViewModelRecipesItem else {
//            return
//        }
        
//        filteredRecipes = profileViewModelRecipesItem.recipes.filter { (recipe: Recipe) -> Bool in
//            let doesMatchCategory = category == nil || recipe.type == category!.rawValue
//            let doesMatchDate = date == nil
//                || Calendar.current.compare(recipe.creationDate, to: date!, toGranularity: .day) == .orderedSame
//
//            if isSearchBarEmpty {
//                return doesMatchCategory && doesMatchDate
//            } else {
//                return doesMatchCategory && doesMatchDate && recipe.title.lowercased().contains(searchText.lowercased())
//            }
//        }
        
//        guard let profileViewModel = profileViewModel, let recipes = profileViewModel.recipes else {
//            return
//        }
        
        guard let recipes = recipes else {
            return
        }
        
        filteredRecipes = recipes.filter { (recipe: Recipe) -> Bool in
            let doesMatchCategory = category == nil || recipe.type == category!.rawValue
            let doesMatchDate = date == nil
                || Calendar.current.compare(recipe.creationDate, to: date!, toGranularity: .day) == .orderedSame

            if isSearchBarEmpty {
                return doesMatchCategory && doesMatchDate
            } else {
                return doesMatchCategory && doesMatchDate && recipe.title.lowercased().contains(searchText.lowercased())
            }
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        if let newRecipeViewController = navigationController.topViewController as? NewRecipeViewController {
            newRecipeViewController.newRecipeDelegate = self
        } else if let detailsViewController = navigationController.topViewController as? DetailsViewController {
            detailsViewController.data = recipeToPass
            detailsViewController.profileViewModel = profileViewModel
        }
    }
}

extension RecipesListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredRecipes.count
        }
    
//        guard let profileViewModel = profileViewModel,
//              profileViewModel.items.count > 0,
//              let profileViewModelRecipesItem = profileViewModel.items[1] as? ProfileViewModelRecipesItem else {
//            return 0
//        }
        
//        guard let profileViewModel = profileViewModel, let recipes = profileViewModel.recipes else {
//            return 0
//        }
        guard let recipes = recipes else {
            return 0
        }
        
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCellIdentifier", for: indexPath) as! RecipeTableViewCell
        
        let recipe: Recipe
        if isFiltering {
            recipe = filteredRecipes[indexPath.row]
        } else {
//            guard let profileViewModelRecipesItem = profileViewModel?.items[1] as? ProfileViewModelRecipesItem else {
//                return cell
//            }
//            recipe = profileViewModelRecipesItem.recipes[indexPath.row]
            
//            guard let recipes = profileViewModel?.recipes else {
//                return cell
//            }
            
            guard let recipes = recipes else {
                return cell
            }
            
            recipe = recipes[indexPath.row]
        }
        
        cell.item = recipe
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let recipe: Recipe
            if isFiltering {
                recipe = filteredRecipes[indexPath.row]
                filteredRecipes.remove(at: indexPath.row)
            } else {
//                guard let profileViewModelRecipesItem = profileViewModel?.items[1] as? ProfileViewModelRecipesItem else {
//                    return
//                }
//                guard let recipes = profileViewModel?.recipes else {
//                    return
//                }
                
                guard let rec = recipes else {
                    return
                }
                
                recipe = rec[indexPath.row]
                //recipes?.remove(at: indexPath.row)
            }
            // here goes deleting the thing from the database
            
            profileViewModel?.removeRecipe(with: recipe.id)
            //setupData()
            NotificationCenter.default.post(name: Notification.Name(GlobalConstants.databaseUpdateNotificationName),
                                            object: nil)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltering {
            recipeToPass = filteredRecipes[indexPath.row]
        } else {
            recipeToPass = recipes?[indexPath.row]
        }
        performSegue(withIdentifier: Constants.detailsSegueName, sender: nil)
    }
}

extension RecipesListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        selectedCategory = DishType(rawValue: searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])
        filterContentForSearchText(searchBar.text!, category: selectedCategory, date: nil)
    }
}

extension RecipesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        selectedCategory = DishType(rawValue: searchBar.scopeButtonTitles![selectedScope])
        filterContentForSearchText(searchBar.text!, category: selectedCategory, date: selectedDate)
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        let alert = UIAlertController(title: "Select date", message: nil, preferredStyle: .actionSheet)

        let datePicker = UIDatePicker()
        datePicker.timeZone = NSTimeZone.local
        datePicker.frame = CGRect(x: 0, y: 15, width: Constants.screenWidth - 10, height: Constants.screenHeight - 10)
        alert.view.addSubview(datePicker)
        let filterAction = UIAlertAction(title: "Choose", style: .default) { [unowned self] _ in
            self.selectedDate = datePicker.date
            filterContentForSearchText(searchBar.text!, category: self.selectedCategory, date: self.selectedDate)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(filterAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}

extension RecipesListViewController: NewRecipeViewControllerDelegate {
    func newRecipeViewController(_ newRecipeViewController: NewRecipeViewController, didAddRecipe recipe: Recipe) {
        profileViewModel?.addRecipe(recipe: recipe)
        recipes?.append(recipe)
        NotificationCenter.default.post(name: Notification.Name(GlobalConstants.databaseUpdateNotificationName),
                                        object: nil)
    }
}
