//
//  NetworkError.swift
//  TheNews
//
//

import Foundation

public enum NetworkError: Error {
    case success
    case malformedURL
    case authenticationError
    case badRequest
    case failed
    case unableToDecodeResponseData(errorDescription: String)
    case other(message: String?)
    
    var localizedDescription: String {
        var message: String = ""
        
        switch self {
        case .malformedURL:
            message = NewsAppConstant.malformedURL
        case .authenticationError:
            message = NewsAppConstant.authenticationError
        case .badRequest:
            message = NewsAppConstant.badRequest
        case .failed:
            message = NewsAppConstant.failed
        case .unableToDecodeResponseData:
            message = NewsAppConstant.unableToDecodeResponseData
        case let .other(errorMessage):
            message = errorMessage ?? ""
        default:
            break
        }
        return message
    }
}
