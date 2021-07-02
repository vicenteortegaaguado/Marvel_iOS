//
//  Font.swift
//  Marvel
//
//  Created by Vicente Ortega Aguado on 27/06/2021.
//

import UIKit

enum Font {
    
    enum Size: CGFloat {
        case large = 20.0
        case medium = 16.0
        case small = 12.0
    }
    
    case regular(Size)
    case bold(Size)
    
    var value: UIFont {
        switch self {
        case .bold(let size): return UIFont.boldSystemFont(ofSize: size.rawValue)
        case .regular(let size): return UIFont.monospacedSystemFont(ofSize: size.rawValue, weight: .regular)
        }
    }
}
