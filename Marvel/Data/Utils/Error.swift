//
//  MarvelError.swift
//  Marvel
//
//  Created by Vicente Ortega Aguado on 27/06/2021.
//

import Foundation

// Common error type
protocol MarvelError: Error {
    var title: String? { get }
    var message: String? { get }
}

enum ErrorType: MarvelError {
    case api(APIError)
    case data(DataError)
    
    var title: String? {
        switch self {
        case .api(let error): return error.title
        case .data(let error): return error.title
        }
    }
    
    var message: String? {
        switch self {
        case .api(let error): return error.message
        case .data(let error): return error.message
        }
    }
}

struct APIError: MarvelError {
    enum HttpStatusCode: Int {
        case missingParameter = 409
        case methodNotAllowed = 405
        case notFound = 404
        case forbidden = 403
        case invalidParameter = 401
        case unknown
        
        init(value: Int?) {
            let code = HttpStatusCode(rawValue: value ?? HttpStatusCode.unknown.rawValue)
            self = code ?? HttpStatusCode.unknown
        }
    }
    
    let code: HttpStatusCode
    let message: String?
    
    var title: String? {
        switch self.code {
        case .missingParameter, .methodNotAllowed, .notFound, .forbidden, .invalidParameter: return "Error \(self.code.rawValue)"
        case .unknown: return "Error"
        }
    }
}

enum DataError: MarvelError {
    case url
    case decoding(description: String)
    
    var title: String? {
        return "Error"
    }
    
    var message: String? {
        switch self {
        case .url: return "Url is not in the correct format"
        case .decoding(let description): return description
        }
    }
}
