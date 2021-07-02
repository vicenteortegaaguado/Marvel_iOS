//
//  LabelStyle.swift
//  Marvel
//
//  Created by Vicente Ortega Aguado on 27/06/2021.
//

import UIKit

enum LabelStyle {
    case title
    case description
    
    var font: UIFont {
        switch self {
        case .title: return Font.bold(.large).value
        case .description: return Font.regular(.medium).value
        }
    }
}

