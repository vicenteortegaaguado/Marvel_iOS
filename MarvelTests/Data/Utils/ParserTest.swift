//
//  ParserTest.swift
//  MarvelTests
//
//  Created by Vicente Ortega Aguado on 30/06/2021.
//

import XCTest
@testable import Marvel

class ParserTest: XCTestCase {

    func testDecodeSuccess() {
        // Given
        let data = getJsonData(from: "characters")
        
        // When & Then
        XCTAssertNoThrow(try Parser<APIResponse<CharacterDataContainer>>.decode(data: data))
    }
    
    func testDecodeError() {
        // Given
        let data = Data()
        
        // When & Then
        XCTAssertThrowsError(try Parser<APIResponse<CharacterDataContainer>>.decode(data: data))
    }
}
