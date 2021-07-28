//
//  GragientView.swift
//  CookingRecipes
//
//  Created by Victoriia Nestrugina on 7/27/21.
//

import UIKit

class GragientView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        updateGradient()
    }

    private func updateGradient() {
        let newLayer = CAGradientLayer()
        newLayer.colors = [UIColor(hue: 0, saturation: 0, brightness: 1, alpha: 0.7).cgColor,
                           UIColor(hue: 0, saturation: 0, brightness: 1, alpha: 0).cgColor]
        newLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: frame.height)
        clipsToBounds = true
        layer.insertSublayer(newLayer, at: 0)
    }

}
