//
// Dish+Extension.swift



import Foundation
import CoreData


extension Dish {
    
    static func createDishesFrom(menuItems:[MenuItem],
                                 _ context:NSManagedObjectContext) {
        for menuItem in menuItems {
            guard let _ = exists(name: menuItem.title, context) else {
                continue
            }
            let oneDish = Dish(context: context)
            oneDish.id = Int64(menuItem.id)
            oneDish.title = menuItem.title
            oneDish.price = menuItem.price
            oneDish.desc = menuItem.desc
            oneDish.image = menuItem.image
            oneDish.category = menuItem.category 
        }
    }
    
    
    static func exists(name: String,
                       _ context:NSManagedObjectContext) -> Bool? {
        let request = Dish.request()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", name)
        request.predicate = predicate
        
        do {
            guard let results = try context.fetch(request) as? [Dish]
            else {
                return nil
            }
            return results.count > 0
        } catch (let error){
            print(error.localizedDescription)
            return false
        }
    }
    
}
