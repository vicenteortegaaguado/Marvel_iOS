//
//  CharactersRepositoryTests.swift
//  MarvelTests
//
//  Created by Vicente Ortega Aguado on 30/06/2021.
//

import XCTest
@testable import Marvel

class CharactersRepositoryTests: XCTestCase {

    private var sut: CharactersRepository!
    private var mockCommunicationManager: MockCommunicationManager!
    
    override func setUp() {
        super.setUp()
        mockCommunicationManager = MockCommunicationManager()
        sut = CharactersRepository(communicationManager: mockCommunicationManager)
    }

    func testGetCharactersSucces() {
        // Given
        mockCommunicationManager.data = getJsonData(from: "characters")
        
        let resultExpectation = XCTestExpectation(description: "result")
        
        // When
        sut.getCharacters(limit: 10, offset: 10) { (result) in
            if case .success = result {
                resultExpectation.fulfill()
            }
        }
        
        // Then
        wait(for: [resultExpectation], timeout: 10)
    }
    
    func testGetCharactersError() {
        // Given
        mockCommunicationManager.error = .api(.init(code: .forbidden, status: nil))
        
        let resultExpectation = XCTestExpectation(description: "result")
        
        // When
        sut.getCharacters(limit: 10, offset: 10) { (result) in
            if case .failure = result {
                resultExpectation.fulfill()
            }
        }
        
        // Then
        wait(for: [resultExpectation], timeout: 10)
    }
    
    func testGetInvalidCharactersSucces() {
        // Given
        mockCommunicationManager.data = getJsonData(from: "invalidCharacters")
        
        let resultExpectation = XCTestExpectation(description: "result")
        
        // When
        sut.getCharacters(limit: 10, offset: 10) { (result) in
            if case .success(let value) = result {
                XCTAssertTrue(value?.results?.isEmpty ?? false)
                resultExpectation.fulfill()
            }
        }
        
        // Then
        wait(for: [resultExpectation], timeout: 10)
    }
}
