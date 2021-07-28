//
//  TableViewAnimator.swift
//  CookingRecipes
//
//  Created by Victoriia Nestrugina on 7/24/21.
//

import Foundation
import UIKit

// defining a typealias for ease of use
typealias TableCellAnimation = (UITableViewCell, IndexPath, UITableView) -> Void

// class to animate the tableViews with the presented animation
final class TableViewAnimator {
    private let animation: TableCellAnimation

    init(animation: @escaping TableCellAnimation) {
        self.animation = animation
    }

    func animate(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) {
        animation(cell, indexPath, tableView)
    }
}
