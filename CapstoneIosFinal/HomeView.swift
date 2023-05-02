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
            }.frame(maxWidth: .infinity )
           Spacer()
            
        }.background(mainColor)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

