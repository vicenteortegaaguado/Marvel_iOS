//
//  Image+Extensions.swift
//  Marvel
//
//  Created by Vicente Ortega Aguado on 27/06/2021.
//

import Foundation

// MARK: Formats

// Image formats and sizes
// https://developer.marvel.com/documentation/images
extension Image {
    
    enum Format {
        enum Size: String {
            case small // all formats
            case medium // all formats
            case large // standard landscape
            case xlarge // all formats
            case amazing // standard landscape
            case fantastic // portrait standard
            case uncanny // standard
            case incredible // portrait landscape
        }
        
        case portrait(Size)
        case standard(Size)
        case landscape(Size)
        
        var value: String {
            switch self {
            case .portrait(let size): return "portrait_" + size.rawValue
            case .standard(let size): return "standard_" + size.rawValue
            case .landscape(let size): return "landscape_" + size.rawValue
            }
        }
    }
}

// MARK: URL Compose

extension Image {
    
    func getURL(with format: Format) -> URL? {
        guard let firstPathComponent = path,
              let lastPathComponent = fileExtension else { return nil }
        
        return URL(string: firstPathComponent + "/" + format.value + "." + lastPathComponent)
    }
}


