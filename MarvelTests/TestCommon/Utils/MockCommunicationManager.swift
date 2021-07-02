//
//  MockCommunicationManager.swift
//  MarvelTests
//
//  Created by Vicente Ortega Aguado on 30/06/2021.
//

import Foundation
@testable import Marvel

final class MockCommunicationManager: CommunicationProtocol {
    
    // To response with 304 http status code
    var isCached: Bool = false
    // Desired data
    var data: Data? = nil
    // Desired error
    var error: ErrorType?
    
    func request<T: Codable>(_ endpoint: Endpoint, model: T.Type, completion: @escaping ((Result<T?, ErrorType>) -> Void)) {
        if isCached { // 304
            completion(.success(nil))
        } else if let error = error {
            completion(.failure(error))
        } else if let data = data {
            let object = try! Parser<APIResponse<T>>.decode(data: data)
            completion(.success(object.data))
        }
    }
}
