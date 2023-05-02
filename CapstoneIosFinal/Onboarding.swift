//
//  Onboarding.swift
//  CapstoneIosFinal
//
//  Created by Glendon Philipp Baculio on 4/28/23.
//

import Foundation
import SwiftUI
import CoreData

let mainColor = Color(red: 73/255,green: 94/255, blue: 87/255, opacity: 1)
let secondaryColor = Color(red: 244/255,green: 206/255, blue: 20/255, opacity: 1)
let mainBg = Color(red: 245/255,green: 245/255, blue: 245/255, opacity: 1)

struct OnboardingView: View {
    let defaults = UserDefaults.standard
//    @EnvironmentObject var appState: AppState
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showValidationAlert = false
 

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    
    private func isValidEmail(_ email: String) -> Bool {
          // Validate email using regular expression
          let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
          let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
          return emailPred.evaluate(with: email)
      }
    
    private func handleRegistration() {
         guard !firstName.isEmpty else {
             showValidationAlert = true
             return
         }
         guard !lastName.isEmpty else {
             showValidationAlert = true
             return
         }
         guard isValidEmail(email) else {
             showValidationAlert = true
             return
         }
         do {
             try viewContext.save()
             defaults.set(firstName, forKey: "firstName")
             defaults.set(lastName, forKey: "lastName")
             defaults.set(email, forKey: "email")
         } catch {
             print("Failed to save user: \(error.localizedDescription)")
         }
     }

    var body: some View {
        VStack {
            VStack {
                Image("littleLemon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250)
                    .padding(.top, 50)
                Spacer()
                TextField("First Name", text: $firstName)
                    .onChange(of: firstName) { value in
                        self.firstName = value
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Last Name", text: $lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.top, 6)
                    .onChange(of: lastName) { value in
                        self.lastName = value
                    }
                
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top, 6)
                    .padding(.bottom, 12)
                    .onChange(of: email) { value in
                        self.email = value
                    }
                Button(action: {
                   handleRegistration()
                }) {
                   Text("Register")
                       .font(.headline)
                       .foregroundColor(secondaryColor)
                       .padding()
                }
                .frame(width: 200)
                .background(mainColor)
                .cornerRadius(10)
                .alert(isPresented: $showValidationAlert) {
                    Alert(title: Text("Error"), message: Text("Please enter a valid first name, last name, and email."), dismissButton: .default(Text("OK")))
                }
                Spacer()
            }
            .padding(.horizontal, 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(mainBg)
        .navigationBarHidden(true)
      
    }
 
}


 
 

 
