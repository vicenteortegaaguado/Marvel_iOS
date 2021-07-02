//
//  CommunicationManager.swift
//  Marvel
//
//  Created by Vicente Ortega Aguado on 27/06/2021.
//

import Foundation

protocol CommunicationProtocol {
    func request<T: Codable>(_ endpoint: Endpoint, model: T.Type, completion: @escaping ((Result<T?, ErrorType>) -> Void))
}

// Responsible for submitting requests and returning responses back to the requestor
final class CommunicationManager: CommunicationProtocol {
    
    private var lastETag: String?
    
    func request<T: Codable>(_ endpoint: Endpoint, model: T.Type, completion: @escaping ((Result<T?, ErrorType>) -> Void)) {
        guard let url = endpoint.url else {
            completion(.failure(.data(.url)))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.httpMethod.rawValue
        // Headers
        // https://developer.marvel.com/documentation/generalinfo
        urlRequest.addValue("*/*", forHTTPHeaderField: "Accept")
        urlRequest.addValue("gzip", forHTTPHeaderField: "Accept-Encoding")
        if let lastETag = lastETag {
            urlRequest.addValue(lastETag, forHTTPHeaderField: "If-None-Match")
        }

        URLSession(configuration: .default).dataTask(with: urlRequest) { [weak self] (data, response, error) in
            let httpResponse = response as? HTTPURLResponse
            
            if let error = error {
                completion(.failure(.api(.init(code: nil, status: error.localizedDescription))))
            } else if let data = data {
                self?.processData(code: httpResponse?.statusCode, data: data, completion: completion)
            } else {
                completion(.failure(.unknown))
            }
        }.resume()
    }
    
    private func processData<T: Codable>(code: Int?, data: Data, completion: @escaping ((Result<T?, ErrorType>) -> Void)) {
        if let apiError = try? Parser<APIError>.decode(data: data) {
            completion(.failure(.api(apiError)))
        } else if code == 304 {
            // Is a cached response return nothing
            completion(.success(nil))
        } else {
            do {
                let object = try Parser<APIResponse<T>>.decode(data: data)
                lastETag = object.etag
                completion(.success(object.data))
            } catch {
                // Wrong public or prive key return a bad formed error from Marvel with String code type
                // Errors format
                // https://developer.marvel.com/documentation/apiresults
                completion(.failure(.data(.decoding(description: error.localizedDescription))))
            }
        }
    }
}
