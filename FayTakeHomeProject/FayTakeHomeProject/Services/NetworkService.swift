import Foundation

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

protocol NetworkServiceProtocol {
    func login(username: String, password: String) async throws -> LoginResponse
    func fetchAppointments(token: String) async throws -> AppointmentsResponse
}

class NetworkService: NetworkServiceProtocol {
    
    private let baseURL: String
    private let session: URLSessionProtocol
    
    init(baseURL: String = "https://node-api-for-candidates.onrender.com",
         session: URLSessionProtocol = URLSession.shared) {
        self.baseURL = baseURL
        self.session = session
    }
    
    func login(username: String, password: String) async throws -> LoginResponse {
        let requestBody = LoginRequest(username: username, password: password)
        let request = try makeRequest(path: "/signin", method: "POST", body: requestBody)
        return try await performRequest(request, as: LoginResponse.self)
    }
    
    func fetchAppointments(token: String) async throws -> AppointmentsResponse {
        let request = try makeRequest(path: "/appointments", method: "GET", token: token)
        return try await performRequest(request, as: AppointmentsResponse.self)
    }
    
    private func makeRequest<T: Encodable>(
        path: String,
        method: String,
        body: T
    ) throws -> URLRequest {
        guard let url = URL(string: "\(baseURL)\(path)") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = try JSONEncoder().encode(body)
        return request
    }
    
    private func makeRequest(
        path: String,
        method: String,
        token: String? = nil
    ) throws -> URLRequest {
        guard let url = URL(string: "\(baseURL)\(path)") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
    
    private func performRequest<T: Decodable>(_ request: URLRequest, as type: T.Type) async throws -> T {
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.serverError("Invalid response")
            }
            
            switch httpResponse.statusCode {
            case 200..<300:
                return try JSONDecoder().decode(T.self, from: data)
            case 401:
                throw NetworkError.unauthorized
            default:
                throw NetworkError.serverError("Server error: \(httpResponse.statusCode)")
            }
        } catch let error as NetworkError {
            throw error
        } catch let urlError as URLError {
            throw NetworkError.serverError(urlError.localizedDescription)
        } catch {
            throw NetworkError.decodingError
        }
    }
}

enum NetworkError: Error, LocalizedError, Equatable {
    case invalidURL
    case noData
    case decodingError
    case unauthorized
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data returned"
        case .decodingError:
            return "Failed to decode response"
        case .unauthorized:
            return "Invalid credentials"
        case .serverError(let message):
            return message
        }
    }
}

// MARK: - URLSession Extension
extension URLSession: URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse) {
        return try await data(for: URLRequest(url: url))
    }
}
