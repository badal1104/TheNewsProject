//
//  NewsAppConstant.swift
//  TheNews
//
//

import Foundation

struct NewsAppConstant {
    
    enum Images {
        static let bookmarkFill = "bookmark.fill"
        static let bookmark = "bookmark"
        static let filter = "line.horizontal.3.decrease.circle"
        static let circle = "circle"
        static let circleSelection = "circle.fill"
        static let emptyBookmark = "bookmark.slash.fill"
        static let refreshIcon = "arrow.clockwise"
    }
    
    
    static let apiKey = "dfa742712f944fa6946f91e3e370be39"
    static let domain = "https://newsapi.org/"
    static let malformedURL = "Malformed URL"
    static let authenticationError = "Authenticatioon failed"
    static let badRequest = "Bad request"
    static let failed = "API request failed"
    static let noResponseData = "Empty response data"
    static let unableToDecodeResponseData = "Unable to decode response object"
    static let defaultCountry = "in"
    static let descriptionNotAvailable = "No description available"
    static let loading = "Loading..."
    static let bookmark = "Bookmarks"
    static let failedToLoadContent = "Failed to load content."
    static let detials = "Details"
    static let bookmarkNotAdded = "No bookmarks yet. Add your favorites to see them here."
}


