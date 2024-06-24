//
//  ResponseDecoder.swift
//  TheNews
//
//

import Foundation

protocol ResponseDecoderProtocol {
    func decode<T: Decodable>(data: Data) async throws -> T
}
struct ResponseDecoder: ResponseDecoderProtocol {
    private let jsonDecoder: JSONDecoder
    init(jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.jsonDecoder = jsonDecoder
    }
   
    func decode<T: Decodable>(data: Data) async throws -> T {
        do {
            jsonDecoder.dateDecodingStrategy = .iso8601
            let model = try jsonDecoder.decode(T.self, from: data)
            return model
        } catch {
            throw NetworkError.unableToDecodeResponseData(errorDescription: error.localizedDescription)
        }
    }
}
