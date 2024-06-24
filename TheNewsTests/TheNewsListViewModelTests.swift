//
//  TheNewsListViewModel.swift
//  TheNewsTests
//
//

import XCTest
import SwiftData
@testable import TheNews

final class TheNewsListViewModel: XCTestCase {
    var sut: NewsListViewModel?
    let mockCacheManager = MockSwiftData()
    
    @MainActor override func setUpWithError() throws {
        mockCacheManager.setCacheManager()
        sut = NewsListViewModel(cacheManager: mockCacheManager.cacheManger)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_bookmark() throws {
        let article = NewsArticleModel(title: "Apple iPhone 16", description: "latest and advance iPhone", url: "", urlToImage: "", publishedAt: Date(), content: "", sourceName: "")
        XCTAssertEqual(article.isBookmark, false, "bookmark not set")
        XCTAssertFalse(article.isBookmark, "bookmark not set")
        
        sut?.bookmark(article: article)
        XCTAssertEqual(article.isBookmark, true, "bookmark set")
        XCTAssertTrue(article.isBookmark, "bookmark  set")
        let bookmarkArticle = try XCTUnwrap(sut?.bookmarkArticle, "Expected response")
        XCTAssertTrue(!bookmarkArticle.isEmpty, "Data expected")
        XCTAssertEqual(bookmarkArticle.count, 1, "1 book should be there")
    }
    
    func test_bookmark_remove() throws {
        let article = NewsArticleModel(title: "Apple iPhone 16", description: "latest and advance iPhone", url: "", urlToImage: "", publishedAt: Date(), content: "", sourceName: "")
        
        XCTAssertEqual(article.isBookmark, false, "bookmark not set") // not added as the bookmark
        XCTAssertFalse(article.isBookmark, "bookmark not set")
        
        sut?.bookmark(article: article) // adding as a bookmark
        XCTAssertEqual(article.isBookmark, true, "bookmark set")
        XCTAssertTrue(article.isBookmark, "bookmark  set")
        let bookmarkArticle = try XCTUnwrap(sut?.bookmarkArticle, "Expected response")
        XCTAssertTrue(!bookmarkArticle.isEmpty, "Data expected")
        XCTAssertEqual(bookmarkArticle.count, 1, "1 book should be there")
        
        
        sut?.bookmark(article: article) // toggle the bookmark, if its already present and remove it from bookmarked array
        let bookmarkArticleEmpty = try XCTUnwrap(sut?.bookmarkArticle, "bookmark array should be empty")
        XCTAssertTrue(bookmarkArticleEmpty.isEmpty, "bookmark array should be empty")
        XCTAssertEqual(bookmarkArticleEmpty.count, 0, "bookmark array should be empty")
    }
    
    func test_get_bookmark_article_index_not_bookmarked() {
        let article = NewsArticleModel(title: "Apple iPhone 16", description: "latest and advance iPhone", url: "", urlToImage: "", publishedAt: Date(), content: "", sourceName: "")
        let index = sut?.getBookmarkArticleIndex(article: article)
        XCTAssertEqual(index, -1, "bookmark not present")
    }
    
    func test_get_bookmark_article_index_when_bookmarked() throws {
        let boomarkedArticle = NewsArticleModel(title: "Samsung S3", description: "just a phone", url: "", urlToImage: "", publishedAt: Date(), isBookmark: true, content: "", sourceName: "")
        
        let bookmarkArray = [NewsArticleModel(title: "Apple iPhone 16", description: "latest and advance iPhone", url: "", urlToImage: "", publishedAt: Date(), content: "", sourceName: ""),
                             boomarkedArticle]
        
        sut?.bookmarkArticle = bookmarkArray
        
        let index = sut?.getBookmarkArticleIndex(article: boomarkedArticle) //getting index of the bookmarked article
        XCTAssertEqual(index, 1, "bookmark should present")
    }
    
    func test_check_if_article_is_bookmarked_failure() {
        
        let notBoomarkedArticle = NewsArticleModel(title: "Samsung S3", description: "just a phone", url: "", urlToImage: "", publishedAt: Date(), isBookmark: false, content: "", sourceName: "")
        
        let bookmarkArray = [NewsArticleModel(title: "Apple iPhone 16", description: "latest and advance iPhone", url: "", urlToImage: "", publishedAt: Date(), content: "", sourceName: ""),
                             notBoomarkedArticle]
        
        sut?.bookmarkArticle = bookmarkArray
        
        sut?.checkBookmark(article: notBoomarkedArticle)

        XCTAssertEqual(notBoomarkedArticle.isBookmark, false, "bookmark not set")
        XCTAssertFalse(notBoomarkedArticle.isBookmark, "bookmark not set")

    }
    
    
    func test_check_if_article_is_bookmarked_success() {
        
        let boomarkedArticle = NewsArticleModel(title: "Apple iPhone 16", description: "latest and advance iPhone", url: "", urlToImage: "", publishedAt: Date(), isBookmark: true, content: "", sourceName: "")
        
        let bookmarkArray = [boomarkedArticle,
                             NewsArticleModel(title: "Samsung S3", description: "just a phone", url: "", urlToImage: "", publishedAt: Date(), isBookmark: false, content: "", sourceName: "")]
        
        sut?.bookmarkArticle = bookmarkArray
        sut?.checkBookmark(article: boomarkedArticle) // checking bookmark again
       
        XCTAssertEqual(boomarkedArticle.isBookmark, true, "bookmark should present") //bookmark added
        XCTAssertTrue(boomarkedArticle.isBookmark, "bookmark should present")
    }
    
    
    func test_default_save_category() throws { // Default business category
        let category = mockCacheManager.cacheManger.fetchCategory()
        let name = try XCTUnwrap(category?.name, "Expected response")
        XCTAssertEqual(name, NewsCategories.business.rawValue, "category should be match")
        XCTAssertNotNil(name, "Data expected")
        XCTAssertTrue(!name.isEmpty, "Data expected")
        XCTAssertEqual(name, NewsCategories.business.rawValue, "category should be match")
    }
    
    func test_update_category_view() throws {
        let category = mockCacheManager.cacheManger.fetchCategory() // Old category
        let name = try XCTUnwrap(category?.name, "Expected response")
        XCTAssertEqual(name, NewsCategories.business.rawValue, "category should be match")
        XCTAssertNotNil(name, "Data expected")
        XCTAssertTrue(!name.isEmpty, "Data expected")
        XCTAssertEqual(name, NewsCategories.business.rawValue, "category should be match")
        
        sut?.selectedCategory = NewsCategories.health.rawValue
        sut?.updatedCategory()
        
        let newCategory = mockCacheManager.cacheManger.fetchCategory() // new Category
        let updateName = try XCTUnwrap(newCategory?.name, "Expected response")
        XCTAssertEqual(updateName, NewsCategories.health.rawValue, "category should be match")
        XCTAssertNotNil(updateName, "Data expected")
        XCTAssertTrue(!updateName.isEmpty, "Data expected")
        XCTAssertEqual(updateName, NewsCategories.health.rawValue, "category should be match")
        
    }

    func test_check_selected_category_not_match() {
        let isCategoryMatch = sut?.checkSelectedCategory(category: NewsCategories.general.rawValue) ?? true
        XCTAssertTrue(!isCategoryMatch, "Category is not matached")
        XCTAssertEqual(isCategoryMatch, false, "Category is not  matached")
    }

    func test_check_selected_category_match() {
        sut?.selectedCategory = NewsCategories.science.rawValue
        let isCategoryMatch = sut?.checkSelectedCategory(category: NewsCategories.science.rawValue) ?? false
        XCTAssertTrue(isCategoryMatch, "Category is matached")
        XCTAssertEqual(isCategoryMatch, true, "Category is matached")
    }
}


