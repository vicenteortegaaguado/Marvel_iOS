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
                completion(.failure(.api(.init(code: .init(value: httpResponse?.statusCode), message: error.localizedDescription))))
            } else if let data = data {
                // Is a cached response return nothing
                if httpResponse?.statusCode == 304 {
                    print("Cached")
                    completion(.success(nil))
                } else {
                    self?.decodeData(data, completion: completion)
                }
            } else {
                completion(.failure(.api(.init(code: .unknown, message: nil))))
            }
        }.resume()
    }
    
    private func decodeData<T: Codable>(_ data: Data, completion: @escaping ((Result<T?, ErrorType>) -> Void)) {
        do {
            let object = try Parser<APIResponse<T>>.decode(data: data)
            lastETag = object.etag
            completion(.success(object.data))
        } catch {
            completion(.failure(.data(.decoding(description: error.localizedDescription))))
        }
    }
}
