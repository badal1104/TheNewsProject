//
//  NewsArticleModel.swift
//  TheNews
//
//

import Foundation


@Observable final class NewsArticleModel: Identifiable, Hashable {
    
    var id = UUID()
    var title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: Date
    var isBookmark = false
    let content: String?
    let source: String
    init(title: String, description: String?, url: String, urlToImage: String?, publishedAt: Date, isBookmark: Bool = false, content: String?, sourceName: String) {
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.isBookmark = isBookmark
        self.content = content
        self.source = sourceName
    }
    
    static var dateFormatter: RelativeDateTimeFormatter = {
        return RelativeDateTimeFormatter()
    }()
    
    var captionText: String {
        "\(source) ‧ \(Self.dateFormatter.localizedString(for: publishedAt, relativeTo: Date()))"
    }
    
    static func == (lhs: NewsArticleModel, rhs: NewsArticleModel) -> Bool {
        return lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

extension NewsArticleModel {
        static var myArticle: NewsArticleModel {
            NewsArticleModel(title: "Prajwal Revanna News LIVE: JD(S) leader\'s medical test, court hearing today - Hindustan Times", description: "Prajwal Revanna News LIVE: Click here for latest updates and news on JD(S) leader Prajwal Revanna\'s case.", url: "https://www.hindustantimes.com/india-news/prajwal-revanna-news-live-updates-jds-bjp-obscene-videos-case-court-hearing-today-may-31-101717121092300.html", urlToImage: "https://www.hindustantimes.com/ht-img/img/2024/05/31/550x309/PTI05-31-2024-000005B-0_1717121635284_1717121670216.jpg", publishedAt: Date(), content: "Prajwal Revanna News LIVE Updates: Suspended JD(S) leader Prajwal Revanna arrived at the Bengaluru airport on Thursday night, and was taken into custody by the Special Investigation Team (SIT) shortl… [+5466 chars]", sourceName: "Livemint")
        }
}
