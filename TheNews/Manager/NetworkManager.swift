//
//  NetworkManager.swift
//  TheNews
//
//

import Foundation

protocol NetworkManagerProtocol {
    func startRequest(endPoint: APIEndPointProvider) async throws -> NetworkResponse
}

final class NetworkManager: NetworkManagerProtocol {
    private var session: URLSession = URLSession.shared
    static let shared = NetworkManager()
    private init() { }
    
    func startRequest(endPoint: APIEndPointProvider) async throws -> NetworkResponse {
        let request = try endPoint.createRequest()
        debugPrint("url >>>>>>>>>>.\(String(describing: request.url))")
        do {
            let response: NetworkResponse = try await session.data(for: request)
            return response
        } catch {
            throw NetworkError.other(message: error.localizedDescription)
        }
    }
    
    func setCustomSession(session: URLSession) {
        self.session = session
    }
}

