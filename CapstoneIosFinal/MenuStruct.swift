import Foundation

//"id": 1,
//      "title": "Greek Salad",
//      "description": "The famous greek salad of crispy lettuce, peppers, olives, our Chicago.",
//      "price": "10",
//      "image": "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/greekSalad.jpg?raw=true",
//      "category": "starters"

struct JSONMenu: Codable {
    let menu: [MenuItem]
}

struct MenuItem: Codable, Hashable {
    let id: Int
    let title: String
    let desc: String
    let price: String
    let image: String
    let category: String
    
    private enum CodingKeys: String, CodingKey {
        case id, title, price, image, category
        case desc = "description"
    }
}
