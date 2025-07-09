import SwiftUI

struct AppointmentsListView: View {
    
    @EnvironmentObject private var authManager: AuthManager
    @StateObject private var viewModel = AppointmentsViewModel()
    
    var body: some View {
        VStack {
            AppointmentsHeaderView(selectedTab: $viewModel.selectedTab)
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(Array(viewModel.filteredAppointments.enumerated()), id: \.element.id) { index, appointment in
                        AppointmentRowView(appointment: appointment, isFirstUpcoming: index == 0 && viewModel.selectedTab == .upcoming)
                    }
                    .padding(.horizontal, 24)
                }
                .padding(.vertical, 24)
            }
            .scrollIndicators(.hidden)
        }
        .task {
            await viewModel.fetchAppointments(token: authManager.token)
        }
    }
}

#Preview {
    NavigationStack {
        AppointmentsListView()
            .environmentObject(AuthManager())
    }
}
