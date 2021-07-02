//
//  CharactersEndpoint.swift
//  Marvel
//
//  Created by Vicente Ortega Aguado on 27/06/2021.
//

import Foundation

enum CharactersEndpoint: Endpoint {
    case characters(limit: Int, offset: Int)
    case character(id: Int)
    
    var path: String {
        switch self {
        case .characters: return "characters"
        case .character(let id): return "characters/\(id)"
        }
    }
    
    var httpMethod: HttpMethod { .GET }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .characters(let limit, let offset):
            return [
                URLQueryItem(name: "limit", value: "\(limit)"),
                URLQueryItem(name: "offset", value: "\(offset)")
            ]
        case .character: return []
        }
    }
}
