//
// DisplayDish.swift



import SwiftUI


struct DisplayDish: View {
    @ObservedObject private var dish:Dish
    @State private var dishImage: UIImage? = nil
    
    init(_ dish:Dish) {
        self.dish = dish
    }
    
    func formatPrice(_ price: Double) -> String {
        let spacing = price < 10 ? " " : ""
        return "$ " + spacing + String(format: "%.2f", price)
    }
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text(dish.title ?? "")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Text(dish.desc ?? "")
                    .padding([.top, .bottom], 7)
                    .foregroundColor(mainColor)
                
                if let price = dish.price {
                    Text(formatPrice(Double(price)!))
                        .monospaced()
                        .font(.callout)
                        .foregroundColor(mainColor)
                        .fontWeight(.medium)
                } else {
                    Text("N/A")
                        .monospaced()
                        .font(.callout)
                        .foregroundColor(mainColor)
                        .fontWeight(.medium)
                }
            }
           
            Spacer()
          
            if let uiImage = dishImage {
                  Image(uiImage: uiImage)
                      .resizable()
                      .cornerRadius(10)
                      .aspectRatio(contentMode: .fit)
                      .frame(width: 100, height: 100)
              } else {
                  // Display a placeholder image
                  Image(systemName: "photo")
                      .resizable()
                      .aspectRatio(contentMode: .fit)
                      .frame(width: 100, height: 100)
                      .foregroundColor(.gray)
                      .onAppear {
                          if let imageUrlString = dish.image, let imageUrl = URL(string: imageUrlString) {
                              URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                                  if let imageData = data, let uiImage = UIImage(data: imageData) {
                                      DispatchQueue.main.async {
                                          self.dishImage = uiImage
                                      }
                                  } else {
                                      // Display another image in case of an error
                                      DispatchQueue.main.async {
                                          self.dishImage = UIImage(named: "error_image")
                                      }
                                  }
                              }.resume()
                          }
                      }
              }
        }.padding(.horizontal, 15)
        Divider()
    }
}
 
