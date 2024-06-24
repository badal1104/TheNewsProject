//
//  NewsCategories.swift
//  TheNews
//
//

import Foundation

enum NewsCategories: String, CaseIterable {
    case business = "Business"
    case entertainment = "Entertainment"
    case general = "General"
    case health = "Health"
    case science = "Science"
    case technology = "Technology"
    case sports = "Sports"
}

extension NewsCategories: Identifiable {
    var id: Self { self }
}
