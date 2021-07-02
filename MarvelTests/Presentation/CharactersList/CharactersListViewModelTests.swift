//
//  CharactersListViewModelTests.swift
//  MarvelTests
//
//  Created by Vicente Ortega Aguado on 29/06/2021.
//

import XCTest
@testable import Marvel

class CharactersListViewModelTests: XCTestCase {
    
    private var sut: CharactersListViewModel!
    private var mockCommunicationManager: MockCommunicationManager!
    
    override func setUp() {
        super.setUp()
        mockCommunicationManager = MockCommunicationManager()
        let repository = CharactersRepository(communicationManager: mockCommunicationManager)
        sut = CharactersListViewModel(marvelRepository: repository)
    }
    
    override func tearDown() {
        sut = nil
        mockCommunicationManager = nil
        super.tearDown()
    }
    
    func testFetchCharactersSuccess() {
        // Given
        mockCommunicationManager.data = getJsonData(from: "characters")
        
        let loadingShow = XCTestExpectation(description: "loadingShow")
        let loadingHide = XCTestExpectation(description: "loadingHide")
        let dataExpectation = XCTestExpectation(description: "data")
        
        sut.loadingHandler = { isLoading in
            isLoading
                ? loadingShow.fulfill()
                : loadingHide.fulfill()
        }
        
        sut.dataHandler = {
            XCTAssertEqual(self.sut.numberOfRows, 10)
            XCTAssertNotNil(self.sut.getCharacter(by: .init(row: 0, section: 0)))
            dataExpectation.fulfill()
        }
        
        // When
        XCTAssertEqual(sut.numberOfRows, 0)
        XCTAssertNil(sut.getCharacter(by: .init(row: 0, section: 0)))
        sut.fetchCharacters()
        
        // Then
        wait(for: [loadingShow, loadingHide, dataExpectation], timeout: 10)
    }

    func testFetchCharactersError() {
        // Given
        mockCommunicationManager.error = .api(.init(code: .forbidden, status: nil))
        
        let loadingShow = XCTestExpectation(description: "loadingShow")
        let loadingHide = XCTestExpectation(description: "loadingHide")
        let errorExpectation = XCTestExpectation(description: "error")
        
        sut.loadingHandler = { isLoading in
            isLoading
                ? loadingShow.fulfill()
                : loadingHide.fulfill()
        }
        
        sut.errorHandler = { (_, _) in
            errorExpectation.fulfill()
        }
        
        // When
        sut.fetchCharacters()
        
        // Then
        wait(for: [loadingShow, loadingHide, errorExpectation], timeout: 10)
    }
    
    func testFetchCachedCharacters() {
        // Given
        mockCommunicationManager.isCached = true
        
        let loadingShow = XCTestExpectation(description: "loadingShow")
        let loadingHide = XCTestExpectation(description: "loadingHide")
        
        sut.loadingHandler = { isLoading in
            isLoading
                ? loadingShow.fulfill()
                : loadingHide.fulfill()
        }
        
        // When
        sut.fetchCharacters()
        
        // Then
        wait(for: [loadingShow, loadingHide], timeout: 10)
    }
}
