import Foundation
import SwiftUI
import CoreData

@main
struct MyApp: App {
    let persistenceController = PersistenceController.shared
    
    @Environment(\.scenePhase) var scenePhase
    @AppStorage("firstName") var firstName = ""
    @AppStorage("lastName") var lastName = ""
    @AppStorage("email") var email = ""
   
  
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if firstName.isEmpty || lastName.isEmpty || email.isEmpty {
                    OnboardingView()
                } else {
                    TabView {
                        HomeView()
                            .tabItem {
                                Image(systemName: "house")
                                Text("Home")
                            }
                        
                        ProfileView()
                            .tabItem {
                                Image(systemName: "person.crop.circle")
                                Text("Profile")
                            }
                    }
                    .accentColor(.purple)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                }
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .inactive:
                do {
                    try PersistenceController.shared.container.viewContext.save()
                } catch {
                    // handle the error
                    fatalError("Failed to save changes")
                }
            default:
                break
            }
        }
    }
}
