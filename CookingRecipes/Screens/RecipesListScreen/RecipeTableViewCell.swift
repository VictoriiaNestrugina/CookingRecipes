//
//  RecipeTableViewCell.swift
//  CookingRecipes
//
//  Created by Victoriia Nestrugina on 7/10/21.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var category: UILabel!
    
    // MARK: - Properties
    
    var item: Recipe? {
        didSet {
            guard let item = item else {
                return
            }
            title?.text = item.title
            category?.text = item.type
            recipeImage.image = item.uiImage
        }
    }
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
