//
//  NewsArticleService.swift
//  TheNews
//
//

import Foundation

typealias NetworkResponse = (data: Data, urlResponse: URLResponse)

protocol NewArticleServiceProtocol {
    func getLatestNews<T: Decodable>(endPoint: APIEndPointProvider) async throws -> T
}

struct NewsService: NewArticleServiceProtocol {
   private let netWorkManager: NetworkManagerProtocol
   private let responseDecoder: ResponseDecoderProtocol
    
    init(netWorkManager: NetworkManagerProtocol = NetworkManager.shared, responseDecoder: ResponseDecoderProtocol = ResponseDecoder()) {
        self.netWorkManager = netWorkManager
        self.responseDecoder = responseDecoder
    }
    
    func getLatestNews<T: Decodable>(endPoint: APIEndPointProvider) async throws -> T {
        do {
            let response: NetworkResponse = try await self.netWorkManager.startRequest(endPoint: endPoint)
            guard let httpResponse = response.urlResponse as? HTTPURLResponse else {
                throw NetworkError.failed
            }
            let responseStatus = self.isValidResposne(response: httpResponse)
           
            switch responseStatus {
            case .success:
                return try await responseDecoder.decode(data: response.data)
            case .failure(let error):
                throw error
            }
        } catch {
           throw error
        }
    }
    
   private func isValidResposne(response: HTTPURLResponse) -> Result<String, NetworkError> {
        switch response.statusCode {
        case 200:
            return .success("Valid Response")
        case 401:
            return .failure(NetworkError.authenticationError)
        default:
            return .failure(NetworkError.failed)
        }
    }
}
