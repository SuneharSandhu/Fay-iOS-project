import SwiftUI

struct AppointmentsHeaderView: View {
    
    @Binding var selectedTab: AppointmentsViewModel.Tab
    
    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Text("Appointments")
                    .font(.title)
                    .fontWeight(.semibold)
                Spacer()
                
                Button(action: {}) {
                    Label("New", image: "newAppointment")
                        .labelStyle(.titleAndIcon)
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.secondary.opacity(0.2))
                    
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            AppointmentsTabView(selectedTab: $selectedTab)
        }
        .background(Color(.systemBackground))
    }
}
