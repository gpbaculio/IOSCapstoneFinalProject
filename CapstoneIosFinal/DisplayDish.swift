//
// DisplayDish.swift



import SwiftUI


struct DisplayDish: View {
    @ObservedObject private var dish:Dish
    init(_ dish:Dish) {
        self.dish = dish
    }
    
    var body: some View {
        HStack{
            Text(dish.title ?? "")
                .padding([.top, .bottom], 7)

            Spacer()

            if let price = dish.price {
                Text(price)
                    .monospaced()
                    .font(.callout)
            } else {
                Text("N/A")
                    .monospaced()
                    .font(.callout)
            }
        }
        .contentShape(Rectangle())
    }
}
 
