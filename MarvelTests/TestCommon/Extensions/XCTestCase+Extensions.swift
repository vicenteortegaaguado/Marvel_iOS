//
//  XCTestCase+Extensions.swift
//  MarvelTests
//
//  Created by Vicente Ortega Aguado on 30/06/2021.
//

import XCTest

extension XCTestCase {
    
    func getJsonData(from fileName: String) -> Data {
        guard let url = Bundle(for: type(of: self)).url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            fatalError("\(fileName) file does not exist")
        }
        return data
    }
}
