//
//  Endpoint.swift
//  Marvel
//
//  Created by Vicente Ortega Aguado on 27/06/2021.
//

import Foundation
import CryptoKit

// Responsible to define mandatory values for url request
protocol Endpoint {
    
    // URL Components
    var scheme: String { get }
    var host: String { get }
    var port: Int { get }
    var version: String { get }
    var url: URL? { get }
    
    var queryItems: [URLQueryItem]? { get }
    var path: String { get }
    
    // URLRequest
    var httpMethod: HttpMethod { get }
}

extension Endpoint {
    
    var scheme: String { "https" }
    var host: String { "gateway.marvel.com" }
    var port: Int { 443 }
    var version: String { "v1" }
    var url: URL? {
        let ts = NSDate().timeIntervalSince1970.description
        guard let url = Bundle.main.url(forResource: "CommunicationKeys", withExtension: "plist"),
              let keys = NSDictionary(contentsOf: url),
              let publicKey: String = keys["public"] as? String,
              let privateKey: String = keys["private"] as? String,
              let hash = getHash(with: "\(ts)\(privateKey)\(publicKey)") else { return nil }
        
        // Form url
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.port = port
        components.path = "/\(version)/public/\(path)"
        components.queryItems = queryItems
        components.queryItems?.append(URLQueryItem(name: "apikey", value: publicKey))
        components.queryItems?.append(URLQueryItem(name: "ts", value: ts))
        components.queryItems?.append(URLQueryItem(name: "hash", value: hash))
        
        return components.url
    }
    
    private func getHash(with value: String) -> String? {
        guard let data = value.data(using: .utf8) else { return nil }
        
        return Insecure.MD5.hash(data: data).map({ String(format: "%02hhx", $0) }).joined()
    }
}
