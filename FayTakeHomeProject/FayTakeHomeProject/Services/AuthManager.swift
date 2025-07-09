import SwiftUI

@MainActor
class AuthManager: ObservableObject {
    
    @Published var isLoggedIn: Bool = false
    @Published var token: String?
    @Published var errorMessage: String?
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func login(username: String, password: String) {
        errorMessage = nil
        
        Task {
            do {
                let response = try await networkService.login(username: username, password: password)
                token = response.token
                isLoggedIn = true
            } catch {
                if let networkError = error as? NetworkError {
                    errorMessage = networkError.localizedDescription
                } else {
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
}
