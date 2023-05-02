//
//  HomeView.swift
//  CapstoneIosFinal
//
//  Created by Glendon Philipp Baculio on 5/1/23.
//

import Foundation
import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
      
    @ObservedObject var dishesModel = DishesModel()
  
    var categories: [String]
    
    @State private var searchText: String = ""
    
    var body: some View {
        VStack {
            HeaderView()
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Little Lemon")
                            .foregroundColor(secondaryColor) .font(.system(size: 36))
                            .fontWeight(.medium)
                        Text("Chicago")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                            .fontWeight(.regular)
                    }
                    Spacer()
                }
                .padding(.leading, 15)
                
                HStack(alignment: .bottom) {
                    Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                        .frame(maxHeight: 165)
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                        .fontWeight(.regular)
                        .frame(maxWidth: 242)
                        .padding(.bottom, 5)
                    Image("Hero image")
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .frame(maxWidth: 147, maxHeight: 152)
                        .cornerRadius(10)
                        .padding(.trailing, 15)
                }
                .padding(.leading, 15)
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search", text: $searchText)
                        .frame(maxHeight: 40)
                }
                .padding(.horizontal)
                .background(.white)
                .cornerRadius(10)
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                
                VStack(alignment: .leading) {
                    VStack {
                        HStack {
                            Text("ORDER FOR DELIVERY!")
                                .foregroundColor(.black)
                                .font(.system(size: 21))
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(.leading, 15)
                        .padding(.top, 15)
                        ScrollView(.horizontal) {
                            HStack(spacing: 10) {
                                ForEach(categories, id: \.self) { category in
                                    Text(category)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .background(mainBg)
                                        .foregroundColor(mainColor)
                                        .cornerRadius(10)
                                }
                            }
                            .padding(.horizontal, 10)
                            .padding(.bottom, 10)
                        }
                        Divider()
                    }
                    NavigationView {
                        ScrollView {
                        FetchedObjects(
                            predicate:buildPredicate(),
                            sortDescriptors: buildSortDescriptors()) {
                                (dishes: [Dish]) in
                                ForEach(dishes, id:\.self) { dish in
                                   
                                        DisplayDish(dish)
                                    }
                            }
                        }
                   }
                }
                .frame(maxWidth: .infinity)
                .background(.white)
            }
            .frame(maxWidth: .infinity)
        }.background(mainColor)
            
    }
    
    private func buildPredicate() -> NSPredicate {
       return searchText == "" ?
       NSPredicate(value: true) :
       NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }
       
    private func buildSortDescriptors() -> [NSSortDescriptor] {
       [
            NSSortDescriptor(
                key: "title",
                ascending: true,
                selector:#selector(NSString.localizedStandardCompare)
            )
       ]
    }
}

 

