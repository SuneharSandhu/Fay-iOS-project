import SwiftUI

@MainActor
class AppointmentsViewModel: ObservableObject {
    
    enum Tab: String, CaseIterable {
        case upcoming = "Upcoming"
        case past = "Past"
    }
    
    @Published var appointments: [Appointment] = []
    @Published var selectedTab: Tab = .upcoming
    @Published var errorMessage: String?
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    var filteredAppointments: [Appointment] {
        return appointments.filter {
            selectedTab == .upcoming ? $0.isUpcoming : $0.isPast
        }
    }
    
    func fetchAppointments(token: String?) async {
        guard let token else {
            errorMessage = "Token is required to fetch appointments."
            return
        }
        
        errorMessage = nil
        
        do {
            let response = try await networkService.fetchAppointments(token: token)
            appointments = response.appointments
        } catch {
            if let networkError = error as? NetworkError {
                errorMessage = networkError.localizedDescription
            } else {
                errorMessage = error.localizedDescription
            }
        }
    }
}
