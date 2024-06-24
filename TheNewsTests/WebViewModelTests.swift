//
//  WebViewModelTests.swift
//  TheNewsTests
//
//

import XCTest
@testable import TheNews

final class WebViewModelTests: XCTestCase {
    var sut: WebViewModel?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = WebViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_update_loading_flag() throws {
        sut?.updateLoadingFlag(value: true)
        let value = try XCTUnwrap(sut?.isLoading, "isLoading should be true")
        XCTAssertTrue(value, "isLoading should be true")
        XCTAssertEqual(value, true, "isLoading should be true")
    }
    
    func test_update_error_value() throws {
        let errorMessage = "not able to load"
        sut?.updateErrorValue(value: errorMessage)
        let value = try XCTUnwrap(sut?.error, "error should not be empty")
        XCTAssertTrue(!value.isEmpty, "error should not be empty")
        XCTAssertEqual(value, errorMessage, "error should not be empty")
    }
    
    func test_update_both_is_loading_and_error() throws {
        let errorMessage = "Loading error"
        let isLoading = false
        
        sut?.updateBothIsLoadingAndError(with: isLoading, error: errorMessage)
        let isLoadingValue = try XCTUnwrap(sut?.isLoading, "isLoading should be false")
        XCTAssertFalse(isLoadingValue, "isLoading should be false")
        XCTAssertEqual(isLoading, isLoadingValue, "isLoading should be false")
        
        let errorValue = try XCTUnwrap(sut?.error, "error should not be empty")
        XCTAssertTrue(!errorValue.isEmpty, "error should not be empty")
        XCTAssertEqual(errorMessage, errorValue, "error should not be empty")
        
    }
    
}
