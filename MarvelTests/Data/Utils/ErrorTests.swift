//
//  ErrorTests.swift
//  MarvelTests
//
//  Created by Vicente Ortega Aguado on 30/06/2021.
//

import XCTest
@testable import Marvel

class ErrorTests: XCTestCase {

    func testAPIError() {
        // Given
        let missingParameter = ErrorType.api(.init(code: .missingParameter, message: "missingParameter"))
        let methodNotAllowed = ErrorType.api(.init(code: .methodNotAllowed, message: "methodNotAllowed"))
        let notFound = ErrorType.api(.init(code: .notFound, message: "notFound"))
        let forbidden = ErrorType.api(.init(code: .forbidden, message: "forbidden"))
        let invalidParameter = ErrorType.api(.init(code: .invalidParameter, message: "invalidParameter"))
        let unknown = ErrorType.api(.init(code: .init(value: nil), message: nil))
        
        // Then
        XCTAssertEqual(missingParameter.title, "Error 409")
        XCTAssertEqual(methodNotAllowed.title, "Error 405")
        XCTAssertEqual(notFound.title, "Error 404")
        XCTAssertEqual(forbidden.title, "Error 403")
        XCTAssertEqual(invalidParameter.title, "Error 401")
        XCTAssertEqual(unknown.title, "Error")
        
        XCTAssertEqual(missingParameter.message, "missingParameter")
        XCTAssertEqual(methodNotAllowed.message, "methodNotAllowed")
        XCTAssertEqual(notFound.message, "notFound")
        XCTAssertEqual(forbidden.message, "forbidden")
        XCTAssertEqual(invalidParameter.message, "invalidParameter")
        XCTAssertEqual(unknown.message, nil)
    }
    
    func testDataError() {
        // Given
        let decoding = ErrorType.data(.decoding(description: "description" ))
        let url = ErrorType.data(.url)
        
        // Then
        XCTAssertEqual(decoding.title, "Error")
        XCTAssertEqual(url.title, "Error")
        
        XCTAssertEqual(decoding.message, "description")
        XCTAssertEqual(url.message, "Url is not in the correct format")
    }
}
