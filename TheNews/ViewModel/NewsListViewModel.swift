//
//  NewsListViewModel.swift
//  TheNews
//
//

import Foundation
import SwiftUI
import SwiftData

@Observable final class NewsListViewModel {
    private var articleService: NewArticleServiceProtocol
    private var cacheManager: SwiftDataManager
    var article: [NewsArticleModel]?
    var bookmarkArticle = [NewsArticleModel]()
    var messageString = ""
    var selectedCategory = NewsCategories.business.rawValue
    var isLoading: Bool = false // Loading state
    var isShowingBookmarks = false
    
    init(articleService: NewArticleServiceProtocol = NewsService(), cacheManager: SwiftDataManager = SwiftDataManager.shared) {
        self.articleService = articleService
        self.cacheManager = cacheManager
        self.saveCategory()
    }
    
    func getLatestNews(endPoint: APIEndPointProvider) async {
        isLoading = true
        defer {
            isLoading = false
        }
        
        do {
            let data: NewsResponse = try await articleService.getLatestNews(endPoint: endPoint)
            let newsArtcileModel = data.transformToNewsArticleModel()
            await assignArticle(newsArtcileModel)
            
        } catch (let error) {
            guard let networkError = error as? NetworkError else {
                return
            }
            await setErrorMessage(networkError.localizedDescription)
        }
        
    }
    
    @MainActor
    private func assignArticle(_ newsArtcileModel: [NewsArticleModel]) {
        self.article = newsArtcileModel
        self.messageString = ""
    }
    
    @MainActor
    private func setErrorMessage(_ errorDescription: String) {
        self.messageString = errorDescription
        self.article?.removeAll()
    }
    
    func filterNews(by category: String) {
        if !checkSelectedCategory(category: category) {
            Task {
                let queryParams = ["country": NewsAppConstant.defaultCountry, "category" : self.selectedCategory]
                let topHeadlines = APIEndPoints.topHeadlines(urlParameters: queryParams)
                await self.getLatestNews(endPoint: topHeadlines)
            }
        }
    }
    
    func checkSelectedCategory(category: String)-> Bool {
        if self.selectedCategory == category {
            return true
        }
        
        self.selectedCategory = category
        self.updatedCategory()
        return false
    }
}

//MARK: - Bookmark actions
extension NewsListViewModel {
    func bookmark(article: NewsArticleModel) {
        article.isBookmark.toggle()
        if article.isBookmark {
            bookmarkArticle.insert(article, at: 0) // Want to show latest bookmark on top
        } else {
            let index = getBookmarkArticleIndex(article: article)
            if index >= 0 {
                bookmarkArticle.remove(at: index)
            }
        }
    }
    
    func checkBookmark(article: NewsArticleModel) {
        let index = getBookmarkArticleIndex(article: article)
        if index >= 0 {
            article.isBookmark = bookmarkArticle[index].isBookmark
        } else {
            article.isBookmark = false
        }
    }
    
    func getBookmarkArticleIndex(article: NewsArticleModel) -> Int {
        bookmarkArticle.firstIndex {$0.title == article.title} ?? -1
    }
}

//MARK: - Local DB actions
extension NewsListViewModel {
    
    func updatedCategory() {
        cacheManager.updateCategory(category: selectedCategory)
    }
    
    private func saveCategory() {
        let category = cacheManager.fetchCategory()
        if let category {
            selectedCategory = category.name
        } else {
            cacheManager.insert(category: selectedCategory)
        }
    }
}
