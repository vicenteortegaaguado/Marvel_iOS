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
    var status: String? { get }
}

enum ErrorType: MarvelError {
    case api(APIError)
    case data(DataError)
    case unknown
    
    var title: String? {
        switch self {
        case .api(let error): return error.title
        case .data(let error): return error.title
        case .unknown: return "Error"
        }
    }
    
    var status: String? {
        switch self {
        case .api(let error): return error.status
        case .data(let error): return error.status
        case .unknown: return "Unknown"
        }
    }
}

struct APIError: MarvelError, Codable {
    enum HttpStatusCode: Int, Codable {
        case missingParameter = 409
        case methodNotAllowed = 405
        case notFound = 404
        case forbidden = 403
        case invalidParameter = 401
    }
    
    let code: HttpStatusCode?
    let status: String?
    
    var title: String? {
        switch self.code {
        case .missingParameter, .methodNotAllowed, .notFound, .forbidden, .invalidParameter:
            var errorCode: String = ""
            if let code = self.code?.rawValue {
                errorCode = "\(code)"
            }
            return "Error \(errorCode)"
        default:
            return "Error"
        }
    }
}

enum DataError: MarvelError {
    case url
    case decoding(description: String)
    
    var title: String? {
        return "Error"
    }
    
    var status: String? {
        switch self {
        case .url: return "Url is not in the correct format"
        case .decoding(let description): return description
        }
    }
}
