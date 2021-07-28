//
//  RecipeTableViewCell.swift
//  CookingRecipes
//
//  Created by Victoriia Nestrugina on 7/10/21.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    // MARK: - Private enum

    private enum State {
        case expanded
        case collapsed

        var change: State {
            switch self {
            case .expanded: return .collapsed
            case .collapsed: return .expanded
            }
        }
    }

    private enum Constants {
        static let methodFieldHeightExpanded = UIScreen.main.bounds.height - 410
    }

    // MARK: - IBOutlet

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var closeButton: UIButton!

    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var ingredientsTextField: UITextView!
    @IBOutlet weak var methodLabel: UILabel!
    @IBOutlet weak var methodTextField: UITextView!
    @IBOutlet weak var methodHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var editButton: UIButton!

    // MARK: - Properties

    var item: Recipe? {
        didSet {
            guard let item = item else {
                return
            }
            title?.text = item.title
            category?.text = item.type
            recipeImage.image = item.uiImage
            ingredientsTextField.text = item.ingredients.joined(separator: "\n")
            methodTextField.text = item.method
        }
    }

    // For cell expansion animation
    var tableView: UITableView?
    var index: Int?

    // MARK: - Private properties

    private var initialFrame: CGRect?
    private var state: State = .collapsed
    private lazy var animator: UIViewPropertyAnimator = {
        return UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut)
    }()

    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Private methods

    private func setupView() {
        methodHeightConstraint.constant = Constants.methodFieldHeightExpanded

        closeButton.isHidden = true
        editButton.isHidden = true
        ingredientsLabel.isHidden = true
        ingredientsTextField.isHidden = true
        methodLabel.isHidden = true
        methodTextField.isHidden = true

        closeButton.alpha = 0
        editButton.alpha = 0
        ingredientsLabel.alpha = 0
        ingredientsTextField.alpha = 0
        methodLabel.alpha = 0
        methodTextField.alpha = 0
    }

    // MARK: - IBAction

    @IBAction func editClicked(_ sender: UIButton) {
        guard let controller = parentViewController as? RecipesListViewController, let recipe = item else {
            return
        }
        controller.edit(recipe: recipe)
        toggle()
    }

    // MARK: - Animation

    @IBAction func close(_ sender: Any) {
        toggle()
    }

    func toggle() {
        switch state {
        case .expanded:
            collapse()
        case .collapsed:
            expand()
        }
    }

    private func expand() {
        guard let tableView = self.tableView else {
            return
        }

        animator.addAnimations {
            self.initialFrame = self.frame

            self.closeButton.isHidden = false
            self.editButton.isHidden = false
            self.ingredientsLabel.isHidden = false
            self.ingredientsTextField.isHidden = false
            self.methodLabel.isHidden = false
            self.methodTextField.isHidden = false

            self.closeButton.alpha = 1
            self.editButton.alpha = 1
            self.ingredientsLabel.alpha = 1
            self.ingredientsTextField.alpha = 1
            self.methodLabel.alpha = 1
            self.methodTextField.alpha = 1

            self.frame = CGRect(x: 0,
                                y: tableView.contentOffset.y,
                                width: tableView.frame.width,
                                height: tableView.frame.height)

            self.layoutIfNeeded()
        }

        animator.addCompletion { position in
            switch position {
            case .end:
                self.state = self.state.change
                tableView.isScrollEnabled = false
                tableView.allowsSelection = false
            default:
                ()
            }
        }

        animator.startAnimation()
    }

    private func collapse() {
        guard let tableView = self.tableView else {
            return
        }

        animator.addAnimations {
            self.closeButton.isHidden = true
            self.editButton.isHidden = true
            self.ingredientsLabel.isHidden = true
            self.ingredientsTextField.isHidden = true
            self.methodLabel.isHidden = true
            self.methodTextField.isHidden = true

            self.closeButton.alpha = 0
            self.editButton.alpha = 0
            self.ingredientsLabel.alpha = 0
            self.ingredientsTextField.alpha = 0
            self.methodLabel.alpha = 0
            self.methodTextField.alpha = 0

            self.frame = self.initialFrame ?? CGRect()

            self.layoutIfNeeded()
        }

        animator.addCompletion { position in
            switch position {
            case .end:
                self.state = self.state.change
                tableView.isScrollEnabled = true
                tableView.allowsSelection = true
            default:
                ()
            }
        }

        animator.startAnimation()
    }
}
