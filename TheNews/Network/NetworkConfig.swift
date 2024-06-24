//
//  NetworkConfig.swift
//  TheNews
//
//

import Foundation

enum HTTPMethod: String {
    case get
    case post
}

enum HeaderContentType: String {
    case json = "application/json"
}

enum HTTPHeaderKeys: String {
    case contentType = "Content-Type"
    case xAPIKey = "X-Api-Key"
}

enum Version: String {
    case v2
}

protocol APIEndPointProvider {
    var baseURL: String { get }
    var version: Version { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [String: String]? { get }
    var headers: [String: String]? { get }
    func absolutePath() -> String
    func createRequest() throws -> URLRequest
}

extension APIEndPointProvider {
    func absolutePath() -> String {
        return baseURL + version.rawValue + path
    }
}
