import SwiftUI

struct AppointmentsTabView: View {
    enum Tab: String, CaseIterable {
        case upcoming = "Upcoming"
        case past = "Past"
    }
    
    @Namespace private var namespace
    @Binding var selectedTab: AppointmentsViewModel.Tab
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                ForEach(AppointmentsViewModel.Tab.allCases, id: \.self) { tab in
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedTab = tab
                        }
                    } label: {
                        VStack(spacing: 4) {
                            Text(tab.rawValue)
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(selectedTab == tab ? Color.accent : Color.gray)
                            
                            if selectedTab == tab {
                                Capsule()
                                    .fill(Color.blue)
                                    .matchedGeometryEffect(id: "underline", in: namespace)
                                    .frame(height: 2)
                            } else {
                                Color.clear.frame(height: 2)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            
            Divider()
        }
    }
}
