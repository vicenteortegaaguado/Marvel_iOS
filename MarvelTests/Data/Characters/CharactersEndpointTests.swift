//
//  CharactersEndpointTests.swift
//  MarvelTests
//
//  Created by Vicente Ortega Aguado on 30/06/2021.
//

import XCTest
@testable import Marvel

class CharactersEndpointTests: XCTestCase {
    
    func testCharacters() {
        // Given
        let sut = CharactersEndpoint.characters(limit: 1, offset: 2)
        
        // Then
        XCTAssertEqual(sut.path, "characters")
        XCTAssertEqual(sut.host, "gateway.marvel.com")
        XCTAssertEqual(sut.scheme, "https")
        XCTAssertEqual(sut.version, "v1")
        XCTAssertEqual(sut.httpMethod, HttpMethod.GET)
        XCTAssertEqual(sut.queryItems, [URLQueryItem(name: "limit", value: "1"), URLQueryItem(name: "offset", value: "2")])
        XCTAssertEqual(sut.port, 443)
        XCTAssertNotNil(sut.url)
    }
}
