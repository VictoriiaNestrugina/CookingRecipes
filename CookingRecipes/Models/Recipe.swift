//
//  Recipe.swift
//  CookingRecipes
//
//  Created by Victoriia Nestrugina on 7/9/21.
//

import Foundation
import RealmSwift
import UIKit

class Recipe: Object {

    // MARK: - Constants

    private enum Constants {
        static let dateFormat: String = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    }

    // MARK: - Properties

    @objc dynamic var id = ""

    @objc dynamic var title = ""
    var ingredients = List<String>()
    @objc dynamic var method = ""
    @objc dynamic var creationDate = Date()
    @objc dynamic var type = DishType.mainCourse.rawValue
    @objc dynamic var image = NSData()

    // MARK: - Initialization

    override init() {
        super.init()
    }

    // MARK: - Static functions

    override static func primaryKey() -> String? {
        return "id"
    }

    static func create(withTitle title: String,
                       ingredients: [String],
                       method: String,
                       type: DishType,
                       image: UIImage) -> Recipe {
        let recipe = Recipe()
        recipe.id = UUID().uuidString
        recipe.title = title
        recipe.ingredients.append(objectsIn: ingredients)
        recipe.method = method
        recipe.type = type.rawValue
        recipe.image = NSData(data: image.jpegData(compressionQuality: 1.0)!)

        return recipe
    }

    var uiImage: UIImage {
        get {
            return UIImage(data: image as Data)!
        }
        set(image) {
            self.image = NSData(data: image.jpegData(compressionQuality: 1.0)!)
        }
    }

    var ingredientsArray: [String] {
        return Array(ingredients)
    }

    // MARK: - FOR IMPORT, just a scratch

    init(json: [String: Any]) {
        super.init()
        //        self.id = json["id"] as! String
        self.title = json["title"] as? String ?? ""
//        self.ingredients.append(objectsIn: (json["ingredients"] as! [[String: Any]]).map {
//            String($0)
//        })
        self.method = json["method"] as? String ?? ""
        self.creationDate = convertStringToDate(string: json["creationDate"] as? String ?? "")
        self.type = json["method"] as? String ?? ""
        self.image = NSData(data: convertBase64StringToImage(imageBase64String: json["image"] as? String ?? "")
                                .jpegData(compressionQuality: 1.0)!)
    }

    // MARK: - Private functions

    private func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }

    private func convertBase64StringToImage (imageBase64String: String) -> UIImage {
        let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image!
    }

    private func convertStringToDate(string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormat
        let date = dateFormatter.date(from: string)!
        return date
    }

    private func convertDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormat
        let createdDate = dateFormatter.string(from: date)
        return createdDate
    }
}
