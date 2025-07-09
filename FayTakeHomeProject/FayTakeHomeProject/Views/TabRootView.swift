import SwiftUI

enum Tab: Hashable {
    case appointments
    case chat
    case journal
    case profile
}

struct TabRootView: View {
    
    @EnvironmentObject var state: TabViewState
    
    var body: some View {
        TabView(selection: $state.selectedTab) {
            NavigationStack {
                AppointmentsListView()
            }
            .tabItem {
                Label("Appointments", image: state.selectedTab == .appointments ? "calendarFill" : "calendar")
            }
            .tag(Tab.appointments)
            
            NavigationStack {
                Text("Chat view")
            }
            .tabItem {
                Label("Chat", image: "chats")
            }
            .tag(Tab.chat)
            
            NavigationStack {
                Text("Journal View")
            }
            .tabItem {
                Label("Journal", image: "notebook")
            }
            .tag(Tab.journal)
            
            NavigationStack {
                Text("Profile view")
            }
            .tabItem {
                Label("Profile", image: "user")
                    .tint(.primary)
            }
            .tag(Tab.profile)
        }
        .onAppear {
            setupTabBarAppearance()
        }
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground
        
        // Selected item styling
        appearance.stackedLayoutAppearance.selected.iconColor = .accent
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.accent
        ]
        
        // Unselected item styling
        appearance.stackedLayoutAppearance.normal.iconColor = .black
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.black
        ]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}

#Preview {
    TabRootView()
        .environmentObject(TabViewState())
}

class TabViewState: ObservableObject {
    @Published var selectedTab: Tab = .appointments
}
