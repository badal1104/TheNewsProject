//
//  SwiftDataManagerTests.swift
//  TheNewsTests
//
//

import XCTest
@testable import TheNews
import SwiftData
final class SwiftDataManagerTests: XCTestCase {
    var sut = SwiftDataManager.shared
    var container: ModelContainer = {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: Category.self, configurations: config)
            return container
        } catch {
            fatalError("Failed to create container")
        }
    }()
    
    @MainActor override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut.setContext(context: container.mainContext)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_fetch_category_empty() {
        let category = sut.fetchCategory()
        XCTAssertNil(category, "Expected nil response")
    }

    func test_fetch_category_when_category_added() throws {
        // Adding category - Entertainment
        sut.insert(category: NewsCategories.entertainment.rawValue)
        let category = sut.fetchCategory()
        let name = try XCTUnwrap(category?.name, "Expected response")
        XCTAssertEqual(name, NewsCategories.entertainment.rawValue, "category should be match")
        XCTAssertNotNil(name, "Data expected")
        XCTAssertTrue(!name.isEmpty, "Data expected")
        XCTAssertEqual(name, NewsCategories.entertainment.rawValue, "category should be match")
    }
    
    func test_update_category() throws {
        
        // Adding category - Science
        sut.insert(category: NewsCategories.science.rawValue)
        let category = sut.fetchCategory()
        let name = try XCTUnwrap(category?.name, "Expected response")
        XCTAssertEqual(name, NewsCategories.science.rawValue, "category should be match")
        XCTAssertNotNil(name, "Data expected")
        XCTAssertTrue(!name.isEmpty, "Data expected")
        XCTAssertEqual(name, NewsCategories.science.rawValue, "category should be match")

        // Updating category - Sports
        sut.updateCategory(category: NewsCategories.sports.rawValue)
        let updatedCategory = sut.fetchCategory()
        let updateCategoryName = try XCTUnwrap(updatedCategory?.name, "Expected response")
        XCTAssertEqual(updateCategoryName, NewsCategories.sports.rawValue, "category should be match")
        XCTAssertNotNil(updateCategoryName, "Data expected")
        XCTAssertTrue(!updateCategoryName.isEmpty, "Data expected")
        XCTAssertEqual(updateCategoryName, NewsCategories.sports.rawValue, "category should be match")

    }
    
}
