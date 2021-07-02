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
        let missingParameter = ErrorType.api(.init(code: .missingParameter, status: "missingParameter"))
        let methodNotAllowed = ErrorType.api(.init(code: .methodNotAllowed, status: "methodNotAllowed"))
        let notFound = ErrorType.api(.init(code: .notFound, status: "notFound"))
        let forbidden = ErrorType.api(.init(code: .forbidden, status: "forbidden"))
        let invalidParameter = ErrorType.api(.init(code: .invalidParameter, status: "invalidParameter"))
        let unknown = ErrorType.api(.init(code: nil, status: nil))
        
        // Then
        XCTAssertEqual(missingParameter.title, "Error 409")
        XCTAssertEqual(methodNotAllowed.title, "Error 405")
        XCTAssertEqual(notFound.title, "Error 404")
        XCTAssertEqual(forbidden.title, "Error 403")
        XCTAssertEqual(invalidParameter.title, "Error 401")
        XCTAssertEqual(unknown.title, "Error")
        
        XCTAssertEqual(missingParameter.status, "missingParameter")
        XCTAssertEqual(methodNotAllowed.status, "methodNotAllowed")
        XCTAssertEqual(notFound.status, "notFound")
        XCTAssertEqual(forbidden.status, "forbidden")
        XCTAssertEqual(invalidParameter.status, "invalidParameter")
        XCTAssertEqual(unknown.status, nil)
    }
    
    func testDataError() {
        // Given
        let decoding = ErrorType.data(.decoding(description: "description" ))
        let url = ErrorType.data(.url)
        
        // Then
        XCTAssertEqual(decoding.title, "Error")
        XCTAssertEqual(url.title, "Error")
        
        XCTAssertEqual(decoding.status, "description")
        XCTAssertEqual(url.status, "Url is not in the correct format")
    }
}
