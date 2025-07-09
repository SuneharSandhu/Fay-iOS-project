import SwiftUI

@main
struct FayTakeHomeProjectApp: App {
    
    @StateObject var appStateContainer = AppStateContainer()
    @StateObject private var authManager = AuthManager()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if authManager.isLoggedIn {
                    TabRootView()
                        .transition(.push(from: .trailing))
                } else {
                    LoginView()
                        .transition(.push(from: .leading))
                }
            }
            .animation(.smooth(duration: 0.3), value: authManager.isLoggedIn)
        }
        .environmentObject(authManager)
        .environmentObject(appStateContainer)
        .environmentObject(appStateContainer.tabViewState)
    }
}

class AppStateContainer: ObservableObject {
  let tabViewState = TabViewState()
}
