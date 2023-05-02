//
// Dish+Extension.swift



import Foundation
import CoreData
import SwiftUI


extension Dish {
    
    static func createDishesFrom(menuItems:[MenuItem],
                                 _ context:NSManagedObjectContext) {
        for menuItem in menuItems {
            guard exists(title: menuItem.title, context) == false else {
                continue
            }
            print("will create dish!", menuItem.title)
            let oneDish = Dish(context: context)
            oneDish.title = menuItem.title
            oneDish.price = menuItem.price
            oneDish.desc = menuItem.desc
            oneDish.image = menuItem.image
            oneDish.category = menuItem.category 
        }
    }
    
    
    static func exists(title: String,
                       _ context:NSManagedObjectContext) -> Bool? {
        let request = Dish.request()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", title)
        request.predicate = predicate
        
        do {
            guard let results = try context.fetch(request) as? [Dish]
                    
            else {
                return nil
            }
            print("results",results)
            return results.count > 0
        } catch (let error){
            print(error.localizedDescription)
            return false
        }
    }
    func saveImage(_ image: UIImage) {
            self.imageData = image.jpegData(compressionQuality: 1.0)
        }
        
        func getImage() -> UIImage? {
            guard let imageData = self.imageData else {
                return nil
            }
            return UIImage(data: imageData)
        }
    
}
