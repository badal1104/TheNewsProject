//
//  NewsResponseModel.swift
//  TheNews
//
//

import Foundation

// MARK: - NewsResponse
struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
    
    func transformToNewsArticleModel()-> [NewsArticleModel] {
       return articles.map {
            NewsArticleModel(title: $0.title, description: $0.description, url: $0.url, urlToImage: $0.urlToImage, publishedAt: $0.publishedAt ?? Date(), content: $0.content, sourceName: $0.source.name)
        }
    }
}

// MARK: - Article
 struct Article: Codable  {
    
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: Date?
    let content: String?
    var isBookmark = false
   
    private enum CodingKeys: String, CodingKey {
        case source, author, title, description, url, urlToImage, publishedAt, content
    }
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}
