//
//  BaseLabel.swift
//  Marvel
//
//  Created by Vicente Ortega Aguado on 27/06/2021.
//

import UIKit

/// Common label
class BaseLabel: UILabel {
    
    // MARK: Init

    init(style: LabelStyle) {
        super.init(frame: .zero)
        configureView(with: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    private func configureView(with style: LabelStyle) {
        font = style.font
    }
}
