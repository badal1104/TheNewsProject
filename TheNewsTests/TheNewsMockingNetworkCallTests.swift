//
//  TheNewsTestsMockingNetworkCall.swift
//  TheNewsTests
//
//

import XCTest
@testable import TheNews
import SwiftData

final class TheNewsTestsMockingNetworkCall: XCTestCase {
    var model: NewsListViewModel?
    let netWorkManager = NetworkManager.shared
    var mockService: NewsService?
    
    override func setUpWithError() throws {
        netWorkManager.setCustomSession(session: getMockUrlSession())
        mockService = NewsService(netWorkManager: netWorkManager)
        model = NewsListViewModel(articleService: mockService!)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        model = nil
        mockService = nil
        MockUrlSessionProtocol.requestHandler = nil
        netWorkManager.setCustomSession(session: .shared)
    }

    func test_Api_mocking_success() async throws {
        let mockData = getSuccessJsonResponse()
        MockUrlSessionProtocol.requestHandler = { request in
            // Assert that the request is made to the correct endpoint
            XCTAssertEqual(request.url?.absoluteString, "https://newsapi.org/v2/top-headlines?country=in")
            
            // Return a mocked response
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, mockData)
        }
        let topHeadlines = APIEndPoints.topHeadlines(urlParameters: [QueryParamKeys.country: NewsAppConstant.defaultCountry])
        await model?.getLatestNews(endPoint: topHeadlines)
        let data = try XCTUnwrap(model?.article, "Expected response")
        XCTAssertTrue(!data.isEmpty, "Data expected")
    }
    
    
    func test_Api_mocking_Error_401() async throws {
        MockUrlSessionProtocol.requestHandler = { request in
            // Return a mocked response
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 401,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, Data())
        }
        let topHeadlines = APIEndPoints.topHeadlines(urlParameters: [QueryParamKeys.country: NewsAppConstant.defaultCountry])
        await model?.getLatestNews(endPoint: topHeadlines)
        let messageString = try XCTUnwrap(model?.messageString, "Expected response")
        XCTAssertFalse(messageString.isEmpty, "Expected response")
        XCTAssertEqual(model?.messageString, NewsAppConstant.authenticationError, "Expected response")
    }
    
    func test_Api_mocking_Error_Failed() async throws {
        MockUrlSessionProtocol.requestHandler = { request in
            // Return a mocked response
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 500,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, Data())
        }
        let topHeadlines = APIEndPoints.topHeadlines(urlParameters: [QueryParamKeys.country: NewsAppConstant.defaultCountry])
        await model?.getLatestNews(endPoint: topHeadlines)
        let messageString = try XCTUnwrap(model?.messageString, "Expected response")
        XCTAssertFalse(messageString.isEmpty, "Expected response")
        XCTAssertEqual(model?.messageString, NewsAppConstant.failed, "Expected response")
    }
    
    func test_Api_mocking_JsonDecoding_Failed() async throws {
        MockUrlSessionProtocol.requestHandler = { request in
            // Return a mocked response
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, nil) // Data nil
        }
        let topHeadlines = APIEndPoints.topHeadlines(urlParameters: [QueryParamKeys.country: NewsAppConstant.defaultCountry])
        await model?.getLatestNews(endPoint: topHeadlines)
        let messageString = try XCTUnwrap(model?.messageString, "Expected response")
        XCTAssertFalse(messageString.isEmpty, "Expected response")
        XCTAssertEqual(model?.messageString, NewsAppConstant.unableToDecodeResponseData, "Expected response")
    }
    
    func getMockUrlSession() -> URLSession  {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.protocolClasses = [MockUrlSessionProtocol.self]
        let session = URLSession(configuration: sessionConfig)
        return session
    }
}

// MARK: - Success Response
private extension TheNewsTestsMockingNetworkCall {
    
    func getSuccessJsonResponse() -> Data {
        return  """
                                        {"status":"ok","totalResults":38,"articles":[{"source":{"id":null,"name":"Hindustan Times"},"author":"Neha Yadav","title":"10 glittering images of space shared by NASA - Hindustan Times","description":"10 glittering images of space shared by NASA","url":"https://www.hindustantimes.com/web-stories/in-focus/10-glittering-images-of-space-shared-by-nasa-101716965880997.html","urlToImage":null,"publishedAt":"2024-05-29T08:30:01Z","content":"By Neha YadavPublished May 29, 2024 Hindustan TimesIn FocusPhoto Credits: NASA"}]}
                                        """.data(using: .utf8)!
        
    }
    
    func getSuccessJsonResponseForCategoryHealth() -> Data {
        return  """
                                        {"status":"ok","totalResults":38,"articles":[{"source":{"id":"google-news","name":"Google News"},"author":"Medical Xpress","title":"Study finds link between genetics and coffee intake - Medical Xpress","description":null,"url":"https://news.google.com/rss/articles/CBMiR2h0dHBzOi8vbWVkaWNhbHhwcmVzcy5jb20vbmV3cy8yMDI0LTA2LWxpbmstZ2VuZXRpY3MtY29mZmVlLWludGFrZS5odG1s0gEA?oc=5","urlToImage":null,"publishedAt":"2024-06-18T16:22:03Z","content":null}]}
                                        """.data(using: .utf8)!
        
    }
    
    
}
