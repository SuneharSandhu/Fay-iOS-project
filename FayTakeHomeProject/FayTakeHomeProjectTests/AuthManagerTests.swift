import Testing

@testable import FayTakeHomeProject

@MainActor
struct AuthManagerTests {
    
    @Test
    func testLoginWithValidCredentials() async throws {
        let mockNetworkService = MockNetworkService()
        let authManager = AuthManager(networkService: mockNetworkService)
        
        authManager.login(username: "john", password: "12345")
        
        try await Task.sleep(nanoseconds: 100_000_000)
        
        #expect(authManager.isLoggedIn)
        #expect(authManager.token == "valid_token_123")
        #expect(authManager.errorMessage == nil)
    }
    
    @Test
    func testLoginWithInvalidCredentials() async throws {
        let mockNetworkService = MockNetworkService()
        let authManager = AuthManager(networkService: mockNetworkService)
        
        authManager.login(username: "invalid", password: "wrong")
        
        try await Task.sleep(nanoseconds: 100_000_000)
        
        #expect(!authManager.isLoggedIn)
        #expect(authManager.token == nil)
        #expect(authManager.errorMessage == "Invalid credentials")
    }
}

class MockNetworkService: NetworkServiceProtocol {
    func login(username: String, password: String) async throws -> LoginResponse {
        if username == "john" && password == "12345" {
            return LoginResponse(token: "valid_token_123")
        } else {
            throw NetworkError.unauthorized
        }
    }
    
    func fetchAppointments(token: String) async throws -> AppointmentsResponse {
        return .init(appointments: [])
    }
}
