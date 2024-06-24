//
//  TheNewsTests.swift
//  TheNewsTests
//
//

import XCTest
@testable import TheNews

final class TheNewsTests: XCTestCase {
    var model: NewsListViewModel?
    override func setUpWithError() throws {
        model = NewsListViewModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        model = nil
    }

    func test_Api() async throws {
        let topHeadlines = APIEndPoints.topHeadlines(urlParameters: ["country": "in"])
         await model?.getLatestNews(endPoint: topHeadlines)
        let data = try XCTUnwrap(model?.article, "Expected response")
        XCTAssertTrue(!data.isEmpty, "Data expected")
    }
}
