//
//  APIResponse.swift
//  Marvel
//
//  Created by Vicente Ortega Aguado on 27/06/2021.
//

import Foundation

// Common Marvel response wrapper
struct APIResponse<T: Codable>: Codable {
    
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let data: T?
    let etag: String?
}
