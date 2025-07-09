import Foundation
import Testing

@testable import FayTakeHomeProject

struct NetworkServiceTests {

    @Test
    func testLoginSuccess() async throws {
        let mockURLSession = MockURLSession()
        let sut = NetworkService(baseURL: "https://test-api.com", session: mockURLSession)
        
        let expectedToken = "test-token"
        let loginResponse = LoginResponse(token: expectedToken)
        let jsonData = try JSONEncoder().encode(loginResponse)
        
        mockURLSession.mockData = jsonData
        mockURLSession.mockResponse = HTTPURLResponse(
            url: URL(string: "https://test-api.com/signin")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        let result = try await sut.login(username: "test", password: "test")
        
        #expect(result.token == expectedToken)
        #expect(mockURLSession.capturedRequest != nil)
        #expect(mockURLSession.capturedRequest?.httpMethod == "POST")
        #expect(mockURLSession.capturedRequest?.url?.path == "/signin")
    }
    
    @Test
    func loginInvalidCredentials() async throws {
        let mockURLSession = MockURLSession()
        mockURLSession.mockResponse = HTTPURLResponse(
            url: URL(string: "https://test-api.com/signin")!,
            statusCode: 401,
            httpVersion: nil,
            headerFields: nil
        )
        
        let sut = NetworkService(baseURL: "https://test-api.com", session: mockURLSession)
        
        await #expect(throws: NetworkError.unauthorized) {
            try await sut.login(username: "invalid", password: "invalid")
        }
    }
    
    @Test("Login with decoding error")
    func loginDecodingError() async throws {
        let mockURLSession = MockURLSession()
        mockURLSession.mockData = "invalid json".data(using: .utf8)
        mockURLSession.mockResponse = HTTPURLResponse(
            url: URL(string: "https://test-api.com/signin")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        let sut = NetworkService(baseURL: "https://test-api.com", session: mockURLSession)
        
        await #expect(throws: NetworkError.decodingError) {
            try await sut.login(username: "testuser", password: "testpass")
        }
    }
    
    
    
    @Test
    func fetchAppointmentsSuccess() async throws {
        let mockURLSession = MockURLSession()
        let sut = NetworkService(baseURL: "https://test-api.com", session: mockURLSession)
        
        let appointment = Appointment(
            appointment_id: "509teq10vh",
            patient_id: "1",
            provider_id: "100",
            status: "Scheduled",
            appointment_type: "Follow-up",
            start: "2024-08-10T17:45:00Z",
            end: "2024-08-10T18:30:00Z",
            duration_in_minutes: 45,
            recurrence_type: "Weekly"
        )
        
        let appointmentsResponse = AppointmentsResponse(appointments: [appointment])
        let jsonData = try JSONEncoder().encode(appointmentsResponse)
        
        mockURLSession.mockData = jsonData
        mockURLSession.mockResponse = HTTPURLResponse(
            url: URL(string: "https://test-api.com/appointments")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        let result = try await sut.fetchAppointments(token: "test-token")
        
        #expect(result.appointments.count ==  1)
        #expect(result.appointments.first?.id ==  "509teq10vh")
    }
    
    @Test
    func testNetworkError() async {
        let mockURLSession = MockURLSession()
        mockURLSession.mockError = URLError(.notConnectedToInternet)
        let sut = NetworkService(baseURL: "https://test-api.com", session: mockURLSession)
        
        await #expect(throws: NetworkError.self) {
            try await sut.login(username: "test", password: "test")
        }
    }
}

// MARK: - Mock URLSession
class MockURLSession: URLSessionProtocol {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?
    var capturedRequest: URLRequest?
    var capturedURL: URL?
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        capturedRequest = request
        
        if let error = mockError {
            throw error
        }
        
        let data = mockData ?? Data()
        let response = mockResponse ?? HTTPURLResponse(
            url: request.url!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!

        return (data, response)
    }
}
