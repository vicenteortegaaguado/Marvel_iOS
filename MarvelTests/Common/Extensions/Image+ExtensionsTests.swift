//
//  Image+ExtensionsTests.swift
//  MarvelTests
//
//  Created by Vicente Ortega Aguado on 01/07/2021.
//

import XCTest
@testable import Marvel

class ImageExtensionsTests: XCTestCase {

    func testFormat() {
        // Given
        let portrait = Image.Format.portrait(.amazing)
        let standard = Image.Format.standard(.amazing)
        let landscape = Image.Format.landscape(.amazing)
        
        // Then
        XCTAssert(portrait.value.contains("portrait_"))
        XCTAssert(standard.value.contains("standard_"))
        XCTAssert(landscape.value.contains("landscape_"))
    }
    
    func testFormatSize() {
        // Given
        let small = Image.Format.portrait(.small)
        let medium = Image.Format.portrait(Image.Format.Size.medium)
        let large = Image.Format.portrait(Image.Format.Size.large)
        let xlarge = Image.Format.portrait(Image.Format.Size.xlarge)
        let amazing = Image.Format.portrait(Image.Format.Size.amazing)
        let fantastic = Image.Format.portrait(Image.Format.Size.fantastic)
        let uncanny = Image.Format.portrait(Image.Format.Size.uncanny)
        let incredible = Image.Format.portrait(Image.Format.Size.incredible)
        
        // Then
        XCTAssert(small.value.contains("small"))
        XCTAssert(medium.value.contains("medium"))
        XCTAssert(large.value.contains("large"))
        XCTAssert(xlarge.value.contains("xlarge"))
        XCTAssert(amazing.value.contains("amazing"))
        XCTAssert(fantastic.value.contains("fantastic"))
        XCTAssert(uncanny.value.contains("uncanny"))
        XCTAssert(incredible.value.contains("incredible"))
    }
    
    func testGetURLSucces() {
        // Given
        let sut = Image(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/40/4bb4680432f73/", fileExtension: "jpg")
        
        // When
        let url = sut.getURL(with: .landscape(.amazing))
        
        // Then
        XCTAssertNotNil(url)
    }

    func testGetURLNil() {
        // Given
        let sut = Image(path: "", fileExtension: nil)
        
        // When
        let url = sut.getURL(with: .landscape(.amazing))
        
        // Then
        XCTAssertNil(url)
    }
}
