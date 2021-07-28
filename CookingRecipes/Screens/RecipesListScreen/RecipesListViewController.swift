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
        static let editSegueName = "editSegue"
        // For table animation
        static let rowHeight: CGFloat = 150
        static let animationDuration: TimeInterval = 0.65
        static let delay: TimeInterval = 0.05
        static let fontSize: CGFloat = 26
    }

    // MARK: - IBOutlet

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Private properties

    private var recipes: [Recipe]?
    private var fullName: String?
    private var recipeToPass: Recipe?

    // an enum of type TableAnimation - determines the animation to be applied to the tableViewCells
    var currentTableAnimation: TableAnimation = .moveUpBounce(rowHeight: Constants.rowHeight,
                                                                duration: Constants.animationDuration,
                                                                delay: Constants.delay)

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
        return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering) || selectedDate != nil
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

    @IBAction func exportRecipes(_ sender: UIBarButtonItem) {
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory,
                                                                  in: .userDomainMask).first else { return }
        let fileUrl = documentDirectoryUrl.appendingPathComponent("Recipes.json")
        guard let recipes = recipes else {
            return
        }
        let recipesArray = recipes.map {
            return $0.convertToEntry()
        }

        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(recipesArray)
            try data.write(to: fileUrl)
        } catch {
            print(error)
        }
    }

    @IBAction func importRecipes(_ sender: UIBarButtonItem) {
        guard let documentsDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                .first else { return }
        let fileUrl = documentsDirectoryUrl.appendingPathComponent("Recipes.json")

        do {
            let data = try Data(contentsOf: fileUrl, options: [])
            let recipesEntries = try JSONDecoder().decode([RecipeEntry].self, from: data)
            profileViewModel?.addRecipes(recipesEntries: recipesEntries)
        } catch {
            print(error)
        }
        tableView.reloadData()
    }

    // MARK: - Methods

    func edit(recipe: Recipe) {
        recipeToPass = recipe
        performSegue(withIdentifier: Constants.editSegueName, sender: nil)
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
        searchController.searchBar.setImage(UIImage(systemName: "calendar"), for: .bookmark, state: .normal)

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
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadData),
                                               name: Notification.Name(GlobalConstants.databaseUpdateNotificationName),
                                               object: nil)
    }

    @objc func reloadData() {
        recipes = profileViewModel?.provideRecipes()
        tableView.reloadData()
    }

    private func filterContentForSearchText(_ searchText: String, category: DishType?, date: Date?) {

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
        guard let navigationController = segue.destination as? UINavigationController else {
            return
        }

        if let newRecipeViewController = navigationController.topViewController as? NewRecipeViewController {
            newRecipeViewController.delegate = self
            if let identifier = segue.identifier, identifier == Constants.editSegueName {
                newRecipeViewController.recipe = recipeToPass
            }
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

        guard let recipes = recipes else {
            return 0
        }

        return recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCellIdentifier", for: indexPath)
                as? RecipeTableViewCell else {
            return UITableViewCell()
        }

        let recipe: Recipe
        if isFiltering {
            recipe = filteredRecipes[indexPath.row]
        } else {
            guard let recipes = recipes else {
                return cell
            }

            recipe = recipes[indexPath.row]
        }

        cell.item = recipe
        cell.tableView = tableView
        cell.index = indexPath.row
        return cell
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let recipe: Recipe
            if isFiltering {
                recipe = filteredRecipes[indexPath.row]
                filteredRecipes.remove(at: indexPath.row)
            } else {
                guard let rec = recipes else {
                    return
                }

                recipe = rec[indexPath.row]
            }

            profileViewModel?.removeRecipe(with: recipe.id)
            setupData()

            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Animation
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? RecipeTableViewCell else {
            return
        }

        selectedCell.toggle()
    }

    // MARK: - Animation

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // fetch the animation from the TableAnimation enum and initialze the TableViewAnimator class
        let animation = currentTableAnimation.getAnimation()
        let animator = TableViewAnimator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
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
        let datePicker = UIDatePicker()
        datePicker.frame = CGRect(x: 15, y: 15, width: 270, height: 100)
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact

        let alert = UIAlertController(title: "Select date", message: "\n\n", preferredStyle: .alert)
        alert.view.addSubview(datePicker)

        let selectAction = UIAlertAction(title: "OK", style: .default, handler: { [unowned self] _ in
            self.selectedDate = datePicker.date
            filterContentForSearchText(searchBar.text!, category: self.selectedCategory, date: self.selectedDate)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addAction(selectAction)
        alert.addAction(cancelAction)

        present(alert, animated: true)
    }
}

extension RecipesListViewController: NewRecipeViewControllerDelegate {
    func newRecipeViewController(_ newRecipeViewController: NewRecipeViewController, didAddRecipe recipe: Recipe) {
        profileViewModel?.addRecipe(recipe: recipe)
        recipes?.append(recipe)
        NotificationCenter.default.post(name: Notification.Name(GlobalConstants.databaseUpdateNotificationName),
                                        object: nil)
    }

    func editRecipeViewController(_ newRecipeViewController: NewRecipeViewController, initial: Recipe, edited: Recipe) {
        profileViewModel?.edit(recipe: initial, with: edited)
        NotificationCenter.default.post(name: Notification.Name(GlobalConstants.databaseUpdateNotificationName),
                                        object: nil)
        recipeToPass = nil
    }
}
