//
//  CharacterDetailTests.swift
//  MarvelTests
//
//  Created by Vicente Ortega Aguado on 30/06/2021.
//

import XCTest
@testable import Marvel

class CharacterDetailViewModelTests: XCTestCase {
    
    private var sut: CharacterDetailViewModel!
    private var mockCommunicationManager: MockCommunicationManager!
    
    override func setUp() {
        super.setUp()
        mockCommunicationManager = MockCommunicationManager()
        let repository = CharactersRepository(communicationManager: mockCommunicationManager)
        sut = CharacterDetailViewModel(character: Character(id: 0), charactersRepository: repository)
    }
    
    override func tearDown() {
        sut = nil
        mockCommunicationManager = nil
        super.tearDown()
    }
    
    func testFetchCharacterSuccess() {
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
            dataExpectation.fulfill()
        }
        
        // When
        sut.fetchCharacter()
        
        // Then
        wait(for: [loadingShow, loadingHide, dataExpectation], timeout: 10)
    }
    
    func testFetchdCharacterError() {
        // Given
        mockCommunicationManager.error = .api(.init(code: .forbidden, message: nil))
        
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
        sut.fetchCharacter()
        
        // Then
        wait(for: [loadingShow, loadingHide, errorExpectation], timeout: 10)
    }
    
    func testFetchdCachedCharacter() {
        // Given
        mockCommunicationManager.isCached = true
        
        let loadingShow = XCTestExpectation(description: "loadingShow")
        let loadingHide = XCTestExpectation(description: "loadingHide")
        let dataExpectation = XCTestExpectation(description: "data")
        
        sut.loadingHandler = { isLoading in
            isLoading
                ? loadingShow.fulfill()
                : loadingHide.fulfill()
        }
        
        sut.dataHandler = {
            dataExpectation.fulfill()
        }
        
        // When
        sut.fetchCharacter()
        
        // Then
        wait(for: [loadingShow, loadingHide, dataExpectation], timeout: 10)
    }
    
    func testFetchFilledCharacter() {
        // Given
        let data = getJsonData(from: "characters")
        let object = try! Parser<APIResponse<CharacterDataContainer>>.decode(data: data)
        let character = object.data?.results?.first
        let repository = CharactersRepository(communicationManager: mockCommunicationManager)
        sut = CharacterDetailViewModel(character: character!, charactersRepository: repository)
        
        let dataExpectation = XCTestExpectation(description: "data")
        
        sut.dataHandler = {
            dataExpectation.fulfill()
        }
        
        // When
        sut.fetchCharacter()
        
        // Then
        wait(for: [dataExpectation], timeout: 10)
    }
}
