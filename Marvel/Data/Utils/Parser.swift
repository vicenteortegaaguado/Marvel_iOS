//
//  Parser.swift
//  Marvel
//
//  Created by Vicente Ortega Aguado on 27/06/2021.
//

import Foundation

struct Parser<T: Codable> {

    static func decode(data: Data) throws -> T {
        do {
            let object = try JSONDecoder().decode(T.self, from: data)
            return object
        } catch {
            throw error
        }
    }
}

