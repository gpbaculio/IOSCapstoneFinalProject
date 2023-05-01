//
//  LogoutView.swift
//  CapstoneIosFinal
//
//  Created by Glendon Philipp Baculio on 5/2/23.
//

import SwiftUI

struct LogoutView: View {
    let onLogout: () -> Void // Add this line
    var body: some View {
        Spacer()
        Button(action: {
            self.onLogout()

        }) {
            Text("Logout")
                .padding(8)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)
                .fontWeight(.medium)
        }.padding(.bottom, 30)
    }
}

 
