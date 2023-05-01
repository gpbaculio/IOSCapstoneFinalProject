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
            Text("Home Screen")
                .font(.largeTitle)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 30)
        .background(mainBg)
        .padding(.bottom, 15)
    }
}
