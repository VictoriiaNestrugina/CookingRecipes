//
//  Indicator.swift
//  CookingRecipes
//
//  Created by Victoriia Nestrugina on 7/20/21.
//

import Foundation
import UIKit

public class Indicator {

    public static let sharedInstance = Indicator()
    var blurImg = UIImageView()
    var indicator = UIActivityIndicatorView()

    private init()
    {
        blurImg.frame = UIScreen.main.bounds
        blurImg.backgroundColor = UIColor.black
        blurImg.isUserInteractionEnabled = true
        blurImg.alpha = 0.5
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.center = blurImg.center
        indicator.startAnimating()
        indicator.color = .white
    }

    func showIndicator(){
        DispatchQueue.main.async( execute: {
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

            if var topController = keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                topController.view.addSubview(self.blurImg)
                topController.view.addSubview(self.indicator)
            }
        })
    }
    func hideIndicator(){

        DispatchQueue.main.async( execute:
            {
                self.blurImg.removeFromSuperview()
                self.indicator.removeFromSuperview()
        })
    }
}
