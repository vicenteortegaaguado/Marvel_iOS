//
//  Character+Extensions.swift
//  Marvel
//
//  Created by Vicente Ortega Aguado on 28/06/2021.
//

import Foundation

extension Character {
    
    // To check data to know character has been instanced by custom initializer
    var isEmpty: Bool {
        name == nil && description == nil
    }
}
