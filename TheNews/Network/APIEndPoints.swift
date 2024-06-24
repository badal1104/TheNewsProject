//
//  APIEndPoints.swift
//  TheNews
//
//

import Foundation

enum APIEndPoints: APIEndPointProvider {
    
    case topHeadlines(urlParameters: [String: String]? = nil)
    
    var baseURL: String {
        switch self {
        default:
            return NewsAppConstant.domain
        }
    }
    
    var version: Version {
        switch self {
        default:
            return .v2
        }
    }
    
    var path: String {
        switch self {
        case .topHeadlines:
            return "/top-headlines"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .topHeadlines:
            return .get
        }
    }
    
    var queryItems: [String : String]? {
        switch self {
        case .topHeadlines(let urlParams):
            return urlParams
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [HTTPHeaderKeys.xAPIKey.rawValue : NewsAppConstant.apiKey]
        }
    }
    
    func createRequest() throws -> URLRequest {
        let url = absolutePath()
        guard let url = URL(string: url) else {
            throw NetworkError.malformedURL
        }
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw NetworkError.malformedURL
        }
        
        if let queryItems, !queryItems.isEmpty {
            var query = [URLQueryItem]()
            for (key, value) in queryItems {
                let queryItem = URLQueryItem(name: key, value: value)
                query.append(queryItem)
            }
            urlComponents.queryItems = query
        }
        guard let url = urlComponents.url else {
            throw NetworkError.malformedURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        return request
    }
}
